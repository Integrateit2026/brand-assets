# Changelog — IntegrateIT Support Surface

## [0.1.2] - 2026-07-31
- The privacy disclosure claimed the support contact name, phone, and email "stay on the controller and are never transmitted". What the driver can actually prove is narrower: its one outbound request carries no headers or body and none of those fields, so IT never transmits them — but it publishes them to the SUPPORT_CONTACT variable precisely so programming can display them, which is not the same as never leaving the controller. The disclosure a dealer shows a client, and the guide, now scope the claim to what the code proves and name where the values actually go.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-20
- First cut: one Navigator experience button that opens a dealer-configured HTTPS support or contact page on touchscreens and in the mobile apps.
- HTTPS-only destination behind a strict validator (scheme, fully qualified host, embedded credentials, control characters, whitespace, port range, unsafe path bytes, 512-character cap); a refusal names its reason in Destination Status and fires Support URL Rejected instead of pushing a bad URL.
- Privacy by construction: the URL opens exactly as entered unless Send Controller Identity is explicitly opted in, contact details never leave the controller, and the read-only Privacy Disclosure property plus the Print Privacy Disclosure action state every request the driver makes.
- No inbound WebView command bridge — only the button press on binding 5001 is handled, so a page in the support WebView cannot drive Control4 through this driver.
- Optional reachability check (On Open or Hourly) with edge-triggered Support Destination Unreachable / Restored events and the dealer's Offline Message published to Status and SUPPORT_MESSAGE.
- Licensing gates events and reachability monitoring; it never withholds the support page itself.
