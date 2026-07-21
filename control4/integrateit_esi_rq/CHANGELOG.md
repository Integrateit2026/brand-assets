# Changelog — IntegrateIT ESI RQ Shades

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
