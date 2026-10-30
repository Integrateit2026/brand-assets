# Changelog — IntegrateIT Somfy URTSI II

## [0.1.4] - 2026-10-30
- Fix: Composer's System Design tree could show this driver as a blank row with no name. Composer draws the device tiles at 16 and 32 px and this build shipped 32 and 300 px ones, so the row rendered as an oversized blank smear. The tiles are re-cut at 16/32 px from the same art. No control changes.

## [0.1.3] - 2026-10-29
- Declares `<serialsettings>9600 8 none 1 none 232</serialsettings>`, so the controller sets the bound RS-232 port to 9600 8N1 (per Somfy's URTSI II operating instructions, the same settings on its RS-232 and RS-485 ports) instead of leaving it at whatever it was last set to.

## [0.1.2] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-20
- Initial release: one-way Somfy URTSI II serial bridge per Somfy's published protocol - up/down/stop and 10-step tilt on channels 1-16, paced command queue, RS-232/RS-485 framing, validated raw-line sender, honest assumed-state events and variables (no position feedback exists on this hardware).
