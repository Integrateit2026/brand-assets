# Changelog — IntegrateIT UniFi Network

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A corrupted port property put :nan/ into every request URL, so every call failed while status kept its last healthy reading.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-21
- Initial release against the official UniFi Network Integration API (local HTTPS, `/proxy/network/integration/v1`, stateless `X-API-KEY` auth minted by the customer on their own UniFi OS console).
- Controller reachability + Network application version (`GET /info`), with Controller Went Online / Offline events.
- Site device health counts (total / online / offline) from the site device list, with UniFi Device Went Offline and All UniFi Devices Online edge events.
- Named-client presence for up to three watched MACs (colon / dash / bare-hex accepted), debounced offline via Offline After (polls); Came Online / Went Offline events per slot.
- One guarded control action: PoE port power-cycle (`POST .../interfaces/ports/<idx>/actions` `{"action":"POWER_CYCLE"}`) — disabled by default, license-gated, LAN-guarded.
- TLS: self-signed console accepted by default (C4:url ssl_verify_* off, hardware-verified); optional Full verification. LAN-only destination safeguard; the API key is never written to the log.
- Pagination safety (pre-release adversarial QA): the Integration API paginates and the driver reads one page (`limit=200`) per poll. A watched client on a site whose client list spans more than one page is now held at its last-known presence instead of being false-declared offline when it lands on a page the driver did not fetch; device-health change events are likewise held until a full page is scanned. Truncation is detected from the envelope (`offset+count < totalCount`). Prevents phantom `Client N Went Offline` and `All UniFi Devices Online` events on large sites.
