# Changelog — IntegrateIT Support Surface

## [0.1.0] - 2026-07-20
- First cut: one Navigator experience button that opens a dealer-configured HTTPS support or contact page on touchscreens and in the mobile apps.
- HTTPS-only destination behind a strict validator (scheme, fully qualified host, embedded credentials, control characters, whitespace, port range, unsafe path bytes, 512-character cap); a refusal names its reason in Destination Status and fires Support URL Rejected instead of pushing a bad URL.
- Privacy by construction: the URL opens exactly as entered unless Send Controller Identity is explicitly opted in, contact details never leave the controller, and the read-only Privacy Disclosure property plus the Print Privacy Disclosure action state every request the driver makes.
- No inbound WebView command bridge — only the button press on binding 5001 is handled, so a page in the support WebView cannot drive Control4 through this driver.
- Optional reachability check (On Open or Hourly) with edge-triggered Support Destination Unreachable / Restored events and the dealer's Offline Message published to Status and SUPPORT_MESSAGE.
- Licensing gates events and reachability monitoring; it never withholds the support page itself.
