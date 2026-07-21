# Changelog — IntegrateIT Nanoleaf

## [0.1.0] - 2026-07-20 (adversarial review pass, same day)
- Fix: every body-carrying write now declares `Content-Type: application/json` (house pattern; the frame was previously sent with no media type).
- Fix: state parsing no longer requires `"value"` to be the first key of each attribute object — a firmware serializing min/max first would have silently blanked POWER/BRIGHTNESS/HUE/SAT/CT.
- Fix: control-write and Test Connection responses now update reachability (DEVICE_ONLINE / Went Online/Offline) — a device dying mid-command previously stayed "online" until the next poll.
- Three regression cases added; runtime suite now 269 checks.

## [0.1.0] - 2026-07-20
- Initial release candidate: single-device control over the Nanoleaf Open API (local HTTP, nanoleaf.atlassian.net/wiki/spaces/nlapid).
- Documented pairing built in: Pair (Claim Token) POSTs /api/v1/new during the power-button window and stores the returned auth token in the password-typed property — never printed, never logged.
- Power on/off/toggle, brightness (1-100), hue/saturation color, and color temperature (1200-6500 K) via PUT /api/v1/&lt;token&gt;/state; effect selection by name via PUT /effects with a List Effects enumerator.
- Configurable state poll (GET /api/v1/&lt;token&gt;/) publishes POWER, BRIGHTNESS, HUE, SAT, CT, EFFECT, and DEVICE_ONLINE, and fires Turned On/Off, Effect Changed, and Went Online/Offline; a tokenless probe keeps reachability working before pairing.
- Token-in-URL secret hygiene (no URL ever logged), LAN-only destination guard with an Allow WAN Nanoleaf override, and MAC-locked IntegrateIT licensing on every control path.
- Known limits: panel line (port 16021) only — Essentials untested; manual IP (no mDNS/SSDP); polling not push; Forget Token clears locally only; streaming/layout/rhythm endpoints out of scope.
