# Changelog — IntegrateIT Future Automation

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
