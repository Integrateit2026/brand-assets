# Changelog — IntegrateIT Bond

## [0.1.0] - 2026-07-20
- Initial release candidate: single-device control over the Bond Home local API v2 (github.com/bondhome/api-v2).
- Ceiling fan (power, ranged speed, increase/decrease, light, brightness, summer/winter direction), shade (open/close/hold), light (on/off/brightness), and generic (toggle power/light) commands via PUT /v2/devices/<id>/actions/<Action>.
- Configurable state poll (GET /v2/devices/<id>/state) publishes POWER, SPEED, LIGHT, BRIGHTNESS, DIRECTION, and DEVICE_ONLINE, and fires Turned On/Off, Light On/Off, and Went Online/Offline.
- BOND-Token header auth (user-supplied, never logged), LAN-only destination guard with an Allow WAN Bond override, and MAC-locked IntegrateIT licensing on every control path.
- Known limits: one device per instance; polling not push (BPUP/mDNS are future work); manual IP + token + device id.
