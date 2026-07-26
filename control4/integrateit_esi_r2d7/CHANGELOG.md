# Changelog — IntegrateIT ESI R2D7 Shades

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-21
- Protocol-fidelity fixes against the manufacturer-published R2D7 V4.1 command table:
  - Command validation is now case-sensitive, per the spec's "case is important: o is different from O." The raw-command sender previously lowercased the command letter, so an uppercase movement letter (e.g. `*1O01`) validated as "open," transmitted a frame the R2D7 actually rejects, and dishonestly marked the channel Assumed Open. Wrong-case letters are now refused with a named reason and never touch the wire or the assumed state.
  - Query Version now sends the administration frame `*V` instead of `*<address>V`. V/R/B are field-2 administration commands that replace the subsystem number; `*1V` was parsed by the unit as subsystem 1 plus an illegal command letter and answered with a bare `U`. The raw sender now accepts `*V`, refuses the `*R`/`*B` port-mode switches, and steers `*1V` to the correct `*V` form.
  - Documentation and the Command Spacing help now state the R2D7's 120-byte input buffer (spec footnote 14), correcting the previous "256 bytes."
- Tests: added wrong-case-refusal and `*V`/`*1V` administration-frame cases; updated the Query Version case to assert the `*V` frame.

## [0.1.0] - 2026-07-21
- Initial release: ESI / Draper R2D7 serial bridge per the manufacturer-published R2D7 V4.1 protocol - open/close/stop for any system address (0-99) and channel (1-60 or ALL), run-to-limits or explicit travel duration, all-systems stop, paced transmit queue honoring the unit's XON/XOFF flow control, acknowledgement diagnostics (acks, U rejections, buffer purges, version reports), validated raw-frame sender that refuses programming/mode letters, honest assumed-state events and variables (the R2D7 has no position feedback).
