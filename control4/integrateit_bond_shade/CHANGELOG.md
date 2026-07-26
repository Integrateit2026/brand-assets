# Changelog — IntegrateIT Bond Shade

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
