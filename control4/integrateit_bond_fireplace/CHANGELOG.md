# Changelog — IntegrateIT Bond Fireplace

## [0.2.0] - 2026-07-30
- New optional Flame Auto-Off (minutes) watchdog, 0 = off by default: after the flame has been observed on for N minutes the driver sends Flame Off through every gate a keypad press passes (license, LAN, type, domain) and fires Watchdog Turned Flame Off only on a dispatched send. It is a convenience layer and NOT a safety device - a successful PUT is the bridge accepting the action, never confirmation the fire went out, and it is no substitute for the appliance's own listed safety systems.
- One armed instance per lit period: the clock starts at the first flame-on observation and is never extended by later ones; flame-off, a rebind, or an IP change cancels it; a Blocked expiry never retries on a stable state hash and re-arms at most once per window when state moves.
- Hard FP type gate at the wire chokepoint: pointing this driver at a Bond shade was sending TurnOn - the flame command - to a window covering. Now refused by name, naming the owning driver, before anything reaches the wire, including the watchdog's own auto-off. A record with no type field is refused rather than guessed at.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-29
- A corrupted Flame Level can no longer put a malformed body on the wire. Values like nan or inf slipped past the range clamp and were transmitted literally as {"argument":nan} - not acceptable at any probability on an appliance that burns gas.
- Same fix for Fan Speed and Brightness; a corrupted numeric property now falls back to that property's documented default rather than reaching the bridge.
- A corrupted Poll Interval (s) can no longer stall state feedback - published flame and fan state kept looking live while silently frozen.
- The transmit chokepoint now refuses a non-finite argument outright, alongside the existing flame/fan/light domain guard - both are invariants of that chokepoint, not of its callers.

## [0.1.0] - 2026-07-26
- Initial release candidate: dedicated single-fireplace control of a Smart by Bond fireplace (device type FP) over the Bond Home local API v2 (github.com/bondhome/api-v2).
- Flame concern: Flame On/Off/Toggle (TurnOn/TurnOff/TogglePower) always available; Flame Up/Down and Set Flame Level (IncreaseFlame/DecreaseFlame/SetFlame, 1-100) offered only where the fireplace was learned with graded flame.
- Independent FpFan concern: Fan On/Off (TurnFpFanOn/TurnFpFanOff) and Set Fan Speed (SetFpFan, clamped 1..max_speed). The safety separation is enforced in code — a fan command issues only FpFan actions and never a flame action, and a flame command never touches the fan; inbound state is applied field-by-field so a fan change never mutates flame variables and vice versa.
- Light concern where flagged: Toggle Light (ToggleLight) and Set Brightness (SetBrightness, 1-100).
- Convenience-only honesty register: the driver provides NO flame supervision, ignition safety, flame-failure detection, gas-valve interlock, or timer-based auto-off, and runs no auto-off timer; the fireplace's own listed safety systems remain the only safety layer. Stated plainly in the packaged docs and the catalog limitations.
- Real push state feedback via the Bond Push UDP Protocol (BPUP) listener on UDP port 30007: keep-alive subscription, \n-delimited JSON frame parsing tolerant of arbitrary datagram boundaries and junk, and resubscribe before the 125s bridge drop.
- Automatic fallback to hash-gated HTTP polling of /state when BPUP goes silent; the Feedback Mode property reports which path is live (Push (BPUP) vs Polling, with the fall-back reason). A 429 Retry-After backs polling off for the requested window with no retry storm.
- Learns FpFan max_speed from /properties and supported features from the device's Bond actions list; an action the fireplace was not learned with is refused as "not supported by this fireplace", while an unknown-support action is attempted so the bridge's own error surfaces (unknown-to-known baseline fires no events).
- Publishes FLAME_POWER, FLAME_LEVEL, FAN_POWER, FAN_SPEED, LIGHT, and DEVICE_ONLINE with transition-only events (unknown->known baseline adoption is silent).
- BOND-Token header auth (user-supplied, never logged, not even in Debug), LAN-only destination guard at the single transport chokepoint with an Allow WAN Bond override, and MAC-locked IntegrateIT licensing re-checked at wire-write time on every control path.
- Known limits: one fireplace per instance; fireplaces (FP) only; no thermostat/setpoint/aux-heat modeling; BPUP needs UDP 30007 reachable or the driver runs poll-only; acceptance on physical hardware is not yet attached to this release.
