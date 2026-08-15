# Changelog — IntegrateIT Generic TCP Toolkit

## [0.1.4] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.3] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A non-finite port or delay could reach the socket layer; both now fall back to their documented defaults.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.1.0] - 2026-07-16
- First release candidate. Original IntegrateIT raw-TCP client for Control4.
- Four labeled command slots plus a raw-payload send, all fireable from Composer programming.
- ASCII/UTF-8 or hex-byte payloads with selectable CR / LF / CR+LF line endings.
- Persistent socket with backed-off auto-reconnect, or on-demand connect-per-send.
- Connected / Disconnected / Response Received / Connection Failed events; DEVICE_ONLINE + LAST_RESPONSE variables.
- Safety: LAN-only destinations by default (WAN opt-in), outbound payload size cap, bounded response buffer, audit logging.
- MAC-locked IntegrateIT licensing with lenient (default) or strict enforcement.
- Simulation verified; representative device acceptance on a controller is still pending.
