# Changelog — IntegrateIT ESI RQ Shades

## [0.1.4] - 2026-10-30
- Fix: Composer's System Design tree could show this driver as a blank row with no name. Composer draws the device tiles at 16 and 32 px and this build shipped 32 and 300 px ones, so the row rendered as an oversized blank smear. The tiles are re-cut at 16/32 px from the same art. No control changes.

## [0.1.3] - 2026-10-29
- Declares `<serialsettings>9600 8 none 1 none 232</serialsettings>`, so the controller sets the bound RS-232 port to the RQ Bridge's 9600 8N1 (per ESI's RQ Bridge v4.0 Command Summary) instead of leaving it at whatever it was last set to. Flow control stays off at the port: an XOFF the controller never follows with XON stalls the bridge with no timeout (ESI), and the driver strips the bridge's XON/XOFF bytes as before.

## [0.1.2] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-20
- Initial release: two-way ESI RQ (M40Q/M50Q / Platinum 2.0 hardwired / Whisper Q) shade driver
  against ESI's published RQ Command Summary (3 Feb 2010 Rev. A).
- Open / Close / Stop / Go To Position (00-99%) / Execute Scene downlink commands.
- Real feedback: r/</> uplink parsing into Position (%) + Motion, Movement Started/Stopped +
  Position Changed events, and decoded E error uplinks (busy / limits-not-set / message-lost).
- Position query on demand, boot re-sync query, optional poll timer, and the !000r?; global
  bus query for address discovery.
- Paced transmit queue, strict-license zero-byte guarantee (listening never gated), bounded
  chunk-safe RX assembly with Xon/Xoff stripping.
