# Changelog — IntegrateIT UniFi Access

## [0.1.3] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- Two fixes: a corrupted port made every URL invalid, and the string-blind reader meant a site with bracket-bearing door names could enumerate 0 of its 3 doors - uncommissionable. Parsing is now string-aware and order-independent.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-21
- Initial release candidate against Ubiquiti's official local Access Developer API (HTTPS :12445, customer-minted Bearer token).
- One door per instance: polled lock relay + door position (DPS) published as DOOR_LOCKED / DOOR_POSITION / DOOR_NAME / DEVICE_ONLINE with Door Opened/Closed, Door Locked/Unlocked, and Went Online/Offline events.
- Remote unlock (PUT /doors/:id/unlock) double-gated: IntegrateIT license AND the dealer-set Allow Remote Unlock switch — monitor-only out of the box; the console logs unlocks under the API token's name.
- List Doors / Test Connection / Print Configuration commissioning actions; hubless doors flagged as not remotely unlockable.
- LAN-only destination safeguard, self-signed-aware TLS (opt-in strict verification), API token never logged.
- Access-convenience surface, not a life-safety system. Simulation-verified; hardware acceptance pending.
- Hardened the door parser against the two forms Ubiquiti's own reference documents beyond the response samples: a JSON `null` `door_position_status` (the reference's "no device is connected" signal) now reads as Unknown instead of pinning the last Open/Closed reading, and a quoted-string `is_bind_hub` (the reference declares the field type String though the sample emits a boolean) is now parsed so the hub-bind unlock guard and the List Doors flag stay correct on spec-conforming firmware.
