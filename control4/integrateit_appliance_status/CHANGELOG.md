# Changelog — IntegrateIT Appliance Status

## [0.1.6] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.5] - 2026-07-31
- Programming-recipe honesty (per research/briefs-2026-07-26/actions-vs-commands-verdict.md, interim rule): the recipes told a dealer to "call Reset Runtime" / "call Acknowledge Maintenance" from programming. Both are Actions-tab entries and this driver declares no programming commands, so those lines are now Actions-tab phrasing and the section states plainly that programming reacts to the events instead.
- Acknowledge Maintenance latches and survives a reboot, so once run, Maintenance Due can never fire again until Reset Runtime clears it. The guide called this "snooze" and the troubleshooting table's "Maintenance never fires" row listed only the threshold and the meter — a dealer whose reminder went permanently silent had no way to find the cause. Both now state the latch and name Reset Runtime as the only thing that re-arms it.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.4] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A poll timer could arm with a nan interval and never fire; it now falls back to its documented default.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.3] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.2] - 2026-07-26
- docs: uniform commissioning guide (DOC-CONTRACT v1)

## [0.1.1] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.1.0] - 2026-07-18
- Initial scaffold (template: contact-relay).
