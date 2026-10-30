# Changelog — IntegrateIT Lutron RadioRA Classic

## [0.1.5] - 2026-10-30
- Fix: Composer's System Design tree could show this driver as a blank row with no name. Composer draws the device tiles at 16 and 32 px and this build shipped 32 and 300 px ones, so the row rendered as an oversized blank smear. The tiles are re-cut at 16/32 px from the same art. No control changes.

## [0.1.4] - 2026-10-29
- Declares `<serialsettings>9600 8 none 1 none 232</serialsettings>`, so the controller sets the bound RS-232 port to 9600 8N1 (per Lutron's RadioRA RS232 Protocol and Programming Guide, P/N 044-038 Rev. A) instead of leaving it at whatever it was last set to. Hardware handshaking stays off, matching the TX/RX/GND wiring Lutron allows.

## [0.1.3] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-21
- Fix: the interface's feedback channels are now asserted at startup (LZCMON / MBPMON / LMPMON / ZMPMON / RSMMON) so live monitoring and the programming-mode queue hold actually work on real hardware. Per Lutron's published protocol (FBKI reference) the RadioRA System Mode (RSM) feedback is OFF by default and every channel is switchable, persistent device state - so without this the driver would never see the pushed RSM,PGM,ENT and would keep transmitting commands the interface silently drops while the system is in programming mode. Priming is ungated (enabling monitoring is not a licensed action, so it runs even when control is license-disabled) and quiet (excluded from the Command Sent event and the Last Command / Commands Sent surfaces), and is paced through the same one-command queue. New "Feedback Monitoring" property (Ensure On default; Leave As-Is opts out when another serial master owns the interface's monitoring state).

## [0.1.0] - 2026-07-20
- Initial release: two-way RadioRA Classic (RadioRA 1) serial bridge per Lutron's published RS232 protocol (P/N 044-038 Rev. A) - SDL/SSL/SGS direct zone control for zones 1-32, BP phantom buttons 1-17 with fade + DS and ALL ON / ALL OFF, live LZC/ZMP/LMP/MBP/RSM/REV feedback parsing into per-zone variables and events, Chronos ,S1/,S2 bridged-pair support, programming-mode queue hold, paced transmit queue. Legacy discontinued product line - protocol is final and frozen.
