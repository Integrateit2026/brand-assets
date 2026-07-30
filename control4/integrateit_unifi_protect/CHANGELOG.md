# Changelog — IntegrateIT UniFi Protect

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- Two fixes: non-finite port hardening, and the string-blind reader undercounted cameras (2 of 4) and could miss Motion Detected entirely on consoles with bracket-bearing camera names. Parsing is now string-aware and order-independent.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-21
- Initial release candidate: events driver for the official Protect Integration API (developer.ui.com/protect, spec v7.1.87) — local HTTPS on the console, X-API-KEY auth with a customer-minted key.
- Camera inventory poll (GET /v1/cameras) publishes CAMERA_COUNT / CAMERAS_CONNECTED and fires Camera Online/Offline on per-camera CONNECTED↔DISCONNECTED transitions; List Cameras prints ids for the Watched Cameras filter.
- Event feed poll (GET /v1/subscribe/events over plain HTTPS) fires Motion Detected/Ended, Smart Detection plus Person/Vehicle/Package/Animal Detected, and Doorbell Ring, with per-event-id dedup and LAST_* camera-name variables; consoles that require the WebSocket upgrade are reported honestly in Event Feed.
- Console reachability (Console Online/Offline + CONSOLE_ONLINE), Test Connection via GET /v1/meta/info (prints the Protect version).
- Self-signed-cert TLS posture (verification relaxed by default, dealer-overridable), LAN-only destination guard with an Allow WAN Console override, API key never logged, and license-gated Composer event delivery.
- Pre-ship adversarial review fixes:
  - License integrity: Console Online/Offline are Composer events (ids 22/23), so their delivery is now inside the license gate like every other device event — a Strict-unlicensed controller no longer receives reachability events. The CONSOLE_ONLINE state mirror still tracks reachability so Status stays honest.
  - Reachability ownership: the console offline verdict is now owned solely by the camera poll's definitive REST endpoint (GET /v1/cameras). The event poll targets a WebSocket endpoint a healthy console can drop with no HTTP response (code 0), so it may only confirm reachability, never declare offline — a transient drop at the fast event cadence no longer flaps Console Offline/Online against the camera poll.
  - deviceState fidelity: CONNECTING (the third official enum value alongside CONNECTED/DISCONNECTED) is treated as a transient midpoint, not a down state — a brief CONNECTED→CONNECTING→CONNECTED blip no longer fires a spurious Camera Offline/Online pair, and a garbage UNKNOWN state no longer moves the published connection state.
- Known limits: events only (no video/streams/snapshots/PTZ); polled feed (latency ≤ one poll interval; WebSocket push not in v0.1.0); camera-offline detection trails by ≤ one camera poll; local console only (no Site Manager cloud proxy).
