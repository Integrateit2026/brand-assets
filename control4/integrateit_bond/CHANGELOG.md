# Changelog — IntegrateIT Bond

## [0.1.4] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.3] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every command, action, event, variable and property name checked for a single spelling across the manifest, the code and this guide; every programming recipe rebuilt from names that actually exist; the commissioning path checked to end in something a dealer can observe; and every claim in the documentation verified against what the code does rather than what it intended.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- The action argument path is now double-hardened: the property reader falls back to its default on non-finite input, and the single transmit chokepoint refuses a non-finite argument by name - the same backstop the rest of the Bond family carries.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-20
- Initial release candidate: single-device control over the Bond Home local API v2 (github.com/bondhome/api-v2).
- Ceiling fan (power, ranged speed, increase/decrease, light, brightness, summer/winter direction), shade (open/close/hold), light (on/off/brightness), and generic (toggle power/light) commands via PUT /v2/devices/<id>/actions/<Action>.
- Configurable state poll (GET /v2/devices/<id>/state) publishes POWER, SPEED, LIGHT, BRIGHTNESS, DIRECTION, and DEVICE_ONLINE, and fires Turned On/Off, Light On/Off, and Went Online/Offline.
- BOND-Token header auth (user-supplied, never logged), LAN-only destination guard with an Allow WAN Bond override, and MAC-locked IntegrateIT licensing on every control path.
- Known limits: one device per instance; polling not push (BPUP/mDNS are future work); manual IP + token + device id.
