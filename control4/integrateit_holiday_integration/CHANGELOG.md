# Changelog — IntegrateIT Holiday Integration

## [0.1.4] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every command, action, event, variable and property name checked for a single spelling across the manifest, the code and this guide; every programming recipe rebuilt from names that actually exist; the commissioning path checked to end in something a dealer can observe; and every claim in the documentation verified against what the code does rather than what it intended.

## [0.1.3] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A dead scheduler timer on a corrupted interval; note the fallback for the schedule preset is now the DECLARED default 3 rather than the code's old 0, because 0 documents 'disabled' and a silent disable is the failure mode this law exists to kill.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.1.0] - 2026-07-18
- Initial scaffold (template: blank).
