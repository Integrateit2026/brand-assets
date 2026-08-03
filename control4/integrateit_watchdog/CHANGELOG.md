# Changelog — IntegrateIT Watchdog

## [0.2.0] - 2026-08-03
- Per-target variables WD_T1_STATE..WD_T6_STATE — program against one target, not the fleet worst
- Relay confirmation: reads the relay proxy reports it always ignored; a relay that has proven it reports and then stays silent past a write fires Relay Unconfirmed (event 41, observational, retries nothing)
- Test Relay 1-4 commissioning actions through the real guard chain minus only the fault requirement; refused while that target's recovery verification is pending
- Cycle outcomes on the record plus Print Target Report forensics action
- Maintenance Hold Auto-Release (h): a forgotten hold can no longer disarm the watchdog forever
- Reset Budget takes two presses inside 30s — a ceiling one click can lift is not a ceiling
- Safety condition 0: Enabled=No now enforces that no relay is ever driven; in-flight cycles render the recovering glyph

## [0.1.0] - 2026-08-03
- Initial release. Six declared LAN targets with per-target name, address, upstream, and
  escalation ladder.
- N-of-M hysteresis (Fail Streak misses to Down, two clean probes to Up) with silent adoption
  of the first settled verdict after boot, an address edit, or a probe-subsystem recovery.
- Declared dependency suppression with a bounded chain walk; a dealer-typed dependency cycle
  suppresses nothing rather than looping.
- Flap classification as a distinct fault: three transitions inside the flap window fire
  Target Flapping, never Target Down, and never actuate.
- First-fault snapshot into a persistent audit ring: every target state, the upstream, the probe
  class, and one optional context device's variables (pcall'd, omitted when unreadable).
- Verified recovery — a recovery grace, then a probe of its own; a failure fires Recovery Failed
  and advances the ladder one rung instead of re-cycling blindly. The verification never adopts a
  scheduled probe that happened to be in flight (that decided a "verified" recovery on evidence
  gathered before the verification began, and when the adopted probe was at the end of its window
  it decided instantly, having verified nothing), never runs for an episode an operator
  acknowledged or an address edit withdrew, and never runs — or takes a verdict — behind a
  faulted upstream, where the miss it would report is the upstream's outage wearing this
  target's name.
- The daily cycle budget is a persisted ledger, not a counter. Both ceilings are derived from
  stamps that survive a controller restart, so a reboot — including one the relay itself caused —
  cannot hand the next fault episode a fresh set of cycles. A stamp the driver cannot age (no
  clock, or a clock that moved backwards) is kept rather than discarded: over-counting a budget
  only ever refuses a cycle.
- An upstream that is mid-verification still suppresses its dependents; without that, every
  dependent dropped out of suppression for the length of the window and re-announced a fault
  nobody had established.
- Relay cycling on bindings 1-4 behind nine independent guards: rung, relay presence, probe
  health, maintenance hold, quiet hours, one-in-flight, per-target daily budget, fleet daily
  budget of four, and the license gate re-checked at the wire write. Restore legs are
  license-exempt so a lapse can never leave a rack dark.
- Quiet hours through an injectable clock; reboot recovery closes a relay left open mid-cycle.
- Ten events (31-40), six WD_ variables, a persistent audit ring with a two-step confirmed clear,
  and five Navigator state icons on the new Sentinel Pulse motif.
