# Changelog: IntegrateIT Hebcal

## [0.9.4] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A corrupted candle-offset reached the API URL as &b=nan and two phantom event fires could follow; the request is now built from finite values only.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.9.3] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.9.2] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.9.1] - 2026-07-16
- Calendar data now commits even when the zmanim endpoint fails; Sunset degrades to Unavailable instead of discarding the whole refresh
- JSON null handling preserves array positions (no more silently skipped calendar items)
- Icons packed at both c4z roots; init errors surface in the Status property

## [0.9.0] - 2026-07-14
- Rebuilt the calendar engine around Hebcal's full 15-day Jewish Calendar API plus exact-date Zmanim API.
- Added timezone-offset-safe event scheduling, DST-safe civil-date arithmetic, and strict date validation.
- Added Hebrew date, Omer, Shabbat, Yom Tov, today's observance, next holiday, timezone, API version, and cache health state.
- Added last-known-good persistence across Director restarts, bounded retry backoff, and Calendar Recovered signaling.
- Hardened JSON parsing with size, nesting, complexity, trailing-data, Unicode, and surrogate-pair validation.
- Expanded runtime coverage to 243 checks with configuration, API contract, timezone, leap year, licensing, recovery, cache, and diagnostics cases.
- Rebuilt the Documentation tab as the IntegrateIT Commissioning Book with the current wordmark and brass footer lockup.
- Added a purpose-built Hebcal calendar icon for Composer.

## [0.1.0] - 2026-07-13
- Added the initial clean-room driver with calendar, zmanim, Control4 events, variables, licensing, updates, and simulation.
