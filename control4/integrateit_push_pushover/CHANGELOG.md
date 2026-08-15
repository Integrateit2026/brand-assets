# Changelog — IntegrateIT Pushover Notifier

## [0.1.5] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.4] - 2026-07-31
- The six sends shipped as Composer ACTIONS only, so Composer Programming could not fire them: an <action> is an Actions-tab button, not a programming command, and this driver's entire purpose is "a programming event pushes an alert". Every documented recipe ("when a door contact reports left open -> Send Message 1") issued a name OnDeviceCommand did not know, and nothing was sent. Each send is now also declared as a programming command and dispatches under both spellings — the command name Director sends from programming and the SEND_* string the Actions-tab button sends.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.3] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A corrupted retry interval meant an EMERGENCY-priority alert was never delivered - the retry timer armed with a nan interval and never fired. On a driver whose whole job is that alert, this was the worst possible silent failure.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.1.0] - 2026-07-16
- Initial scaffold (template: http-device).
