# Changelog — IntegrateIT Future Automation

## [0.1.4] - 2026-10-30
- Fix: Composer's System Design tree could show this driver as a blank row with no name. Composer draws the device tiles at 16 and 32 px and this build shipped 32 and 300 px ones, so the row rendered as an oversized blank smear. The tiles are re-cut at 16/32 px from the same art. No control changes.

## [0.1.3] - 2026-10-29
- Declares `<serialsettings>9600 8 none 1 none 232</serialsettings>`, so on the RS-232 transport the controller sets the bound port to 9600 8N1 (per Future Automation's installation manuals, RS232 CONTROL section) instead of leaving it at whatever it was last set to. The TCP transport is unchanged: a serial-over-IP gateway is still configured on the gateway.

## [0.1.2] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-21
- Initial release candidate: Future Automation mechanism control over the published
  RS-232 token protocol (fa_in / fa_out / fa_stop / fa_home / fa_left / fa_right /
  fa_preset / fa_a / fa_b / fa_c / fa_store), CR-terminated at 9600 8N1.
- Dual transport, property-selected: direct RS-232 serial binding, or raw-TCP
  serial-over-IP gateway with LAN-only destination enforcement, auto-reconnect,
  and in-order queue flush on connect.
- Paced transmit queue with configurable inter-command spacing.
- Command Set selector so simple lift ranges refuse articulated/swivel tokens;
  Store Position guarded behind an explicit enable.
- Honest assumed-position model for the write-only protocol: Command Sent,
  Mechanism Assumed In / Out / Stopped, and Preset Recalled events; assumed
  position resets to Unknown on reboot by design.
- MAC-locked IntegrateIT licensing (lenient/strict) gating every wire write,
  including queued tokens at transmit time.
- Safety: Stop (fa_stop) now preempts the paced queue and the inter-command
  spacing window instead of waiting behind them. A lift is moving furniture, and
  a Stop that queued behind pending moves (or sat out a spacing interval up to
  2 s) kept the mechanism travelling — and any movement token ahead of it drove
  it first. Stop now discards the stale movement backlog and transmits
  immediately on the active transport (serial or gateway), still license-gated.
  This makes the "stop immediately" contract in the command and protocol docs
  actually true.
- Fixed a TCP auto-reconnect gap: a connect attempt that failed by reporting
  OFFLINE (never having reached ONLINE) cancelled the connect watchdog without
  scheduling a retry, wedging the gateway at "Not connected" despite the
  keep-open intent. Failed initial connects now re-arm the reconnect backoff.
