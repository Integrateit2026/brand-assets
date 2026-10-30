# Changelog — IntegrateIT Mode Integration

## [0.1.4] - 2026-10-30
- Fix: Composer's System Design tree could show this driver as a blank row with no name. Composer draws the device tiles at 16 and 32 px and this build shipped 32 and 300 px ones, so the row rendered as an oversized blank smear. The tiles are re-cut at 16/32 px from the same art. No control changes.

## [0.1.3] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.1.0] - 2026-07-16
- Initial scaffold (template: blank).
