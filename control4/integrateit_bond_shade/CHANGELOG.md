# Changelog — IntegrateIT Bond Shade

## [0.1.3] - 2026-07-30
- Hard MS type gate inside the single actuation chokepoint, so Open/Close/Hold/Preset/Set Position/Toggle Open and the delayed Hold of an assumed move are all covered by one check: pointing this driver at a Bond fireplace was sending Open to it AND starting a phantom dead-reckoned move with a position the device does not have. Refused by name now, and List Bond Shades lists the whole bridge naming each device's owner instead of hiding non-shades.
- A rebind or IP change mid-travel now cancels the in-flight assumed move - previously the delayed Hold fired at the NEW device and POSITION published the old shade's target - and the rebind reset no longer stamps a device-reported claim onto a device whose record was never read.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.2] - 2026-07-29
- Fixes a case where an assumed-position shade could be driven and never stopped. A corrupted Set Position made the computed Hold time nan, so the stop command was scheduled and never fired - the shade traveled to its endpoint with the driver still reporting moving.
- A corrupted Course Time (s) no longer strands a move on a settle timer that never fires, and a corrupted Poll Interval (s) no longer kills polling.
- Set Position and Preset Argument can no longer put a malformed body like {"argument":nan} on the wire.
- A corrupted numeric property now falls back to its documented default, and the single transmit chokepoint refuses a non-finite argument outright - reporting nothing was sent, so no phantom move begins.

## [0.1.1] - 2026-07-26
- Fix (P0, wire fidelity): Bond's `position` percentage is inverted versus this driver's Control4 convention — the api-v2 Position feature documents it verbatim as "0 = open, 100 = closed", while the driver (and the `open` flag) use 0 = closed / 100 = open. The device-reported/Bridge Pro path read and wrote the raw Bond value, so a fully open shade (`position:0`) was published as closed (firing Shade Closed), the on-frame `position` and `open` fields contradicted each other, and "Set Position 80%" transmitted `argument:80` = ~80% closed, moving the shade the wrong way. Both the state read (`100 - p`) and the SetPosition argument (`100 - target`) are now flipped on the wire. The `open`-flag and assumed-CourseTime paths were already correct and are unchanged. Added regression cases proving Bond position 0 = fully open (fires Shade Opened) and a 35%-open target ships as argument 65.

## [0.1.0] - 2026-07-26
- Initial release candidate: dedicated single-shade control of a Bond Home motorized shade (device type MS) over the Bond local API v2 (github.com/bondhome/api-v2).
- Open, Close, Stop (Hold), Set Preset, Toggle Open, and Set Position via PUT /v2/devices/<id>/actions/<Action>.
- Position contract by capability: SetPosition is a real action where the shade's action list reports position support; otherwise an honest CourseTime assumed-position model — dead-reckoned from a configurable travel time, labeled ASSUMED via POSITION_ASSUMED, Unknown at boot, with a partial move requiring a known endpoint and a mid-travel stop returning to Unknown.
- State feedback by BPUP push over UDP port 30007 (keep-alive every 60s, 125s stale watchdog) with a hash-gated GET /v2/devices/<id>/state fallback; the active mode is stated in Device Status.
- Publishes POSITION, POSITION_ASSUMED, STATE, and DEVICE_ONLINE, and fires transition-only Motion Started/Stopped, Shade Opened/Closed, and Went Online/Offline.
- BOND-Token header auth (user-supplied, never logged), LAN-only destination guard with an Allow WAN Bond override, license gate on every actuating path with a wire-write-time re-check on the delayed Hold, and no-retry-storm handling of transient Bond errors.
- Known limits: one shade per instance; simulation-verified, not bench-tested; an assumed-position shade cannot report a remote move until the next driver command.
