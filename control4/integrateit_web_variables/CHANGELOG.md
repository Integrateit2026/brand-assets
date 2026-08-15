# Changelog — IntegrateIT Web Variables

## [0.1.2] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.1] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- The self-re-arming poll could die forever on one corrupted interval while the status property still read OK - the exact silent-freeze this wave's law exists to kill.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [Unreleased]
- Pre-ship fix: `pathOnly` now strips the ENTIRE URL userinfo before logging or Print Configuration. The prior `://[^/@]*@` strip stopped at the first `@`, so a basic-auth password containing an unencoded `@` left a credential fragment (`ss@host`) in the debug log and diagnostics — violating the stated "no userinfo in the log" guarantee. Now `://[^/]*@`, greedy to the last `@` in the authority. Regression test added.
- Pre-ship hardening + doc-honesty: the modern `C4:url()` transport is now explicitly told `follow_redirects=false`, so a 3xx surfaces as an honest non-2xx failed poll instead of being chased to an unvalidated (possibly non-http) Location. Corrected the destination-safety comment, which had overstated the driver as "refusing redirect targets with a different scheme" — it never followed or re-validated a redirect at all.

## [0.1.0] - 2026-07-26
- First release candidate. Original IntegrateIT HTTP-poll-to-variable driver for Control4 — the second artifact of the generic-tcp-toolkit family.
- Polls a dealer-configured HTTP/HTTPS endpoint on a bounded interval and publishes extracted values as Control4 variables, so any web/JSON/plain-text source is programmable in Composer with no custom code.
- Four extraction slots, each a JSON path (a.b[0].c) or a Lua text-capture pattern; response type auto-detected by content, overridable to JSON or Text.
- Publishes a STRING variable per slot, a NUMBER variable when the value parses numeric, a per-slot SLOT_n_OK flag, plus LAST_POLL, HTTP_STATUS, and POLL_OK.
- Per-slot Changed events fire on value transitions only — the first population after boot stays silent (house rule). Poll Failed / Poll Recovered track reachability.
- Honesty and safety: http/https-only destination gate, per-slot state kept honest on a miss (value stays last-known, OK drops), response-size cap with truncation reporting, and a request header that is sent but never logged. Debug logs method + path only; bodies only when Debug Response Bodies = Bodies.
- Polling is gated on the license: under Strict enforcement an unlicensed controller opens no request and fires no events.
- MAC-locked IntegrateIT licensing with lenient (default) or strict enforcement; self-update and diagnostics inherited from the shared runtime.
- Simulation verified; representative endpoint acceptance on a controller is still pending.
