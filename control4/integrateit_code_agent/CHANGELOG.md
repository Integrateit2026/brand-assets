# Changelog — IntegrateIT Code Agent

## [0.1.3] - 2026-07-31
- ID RETIRE OK — the three declared command names change in this release, deliberately. Read the next bullet before updating a project that already programs this driver.
- The three programming commands were declared as RUN_SCRIPT / ABORT_RUN / SET_REGISTER, so Composer Programming listed them in SCREAMING_SNAKE while the guide called them Run Script / Abort Run / Set Register — a dealer following the documentation looked for a command that was not in the list under that name. The declared names are now the human ones, the convention every other driver in the fleet follows. **If an existing project has RUN_SCRIPT, ABORT_RUN, or SET_REGISTER dragged into a programming script, re-drag it as Run Script / Abort Run / Set Register after the update** — Composer binds programming to the declared name, so a renamed command leaves the old line orphaned. Nothing else breaks: the runtime still answers the old spellings, so any driver-to-driver call and any queued command keeps working, and there was no way to hold both names in the list without leaving every dealer a permanently duplicated command tree.
- Set Register refusals now name the real cause. A Control4 command carries no parameter fields into Composer Programming, so firing it from programming supplies no REGISTER and it refused with "invalid register name" — blaming the dealer for a field they were never given. It now reads "no REGISTER parameter supplied", and the guide states that the parameterized path is the driver-to-driver one.
- Documentation corrections: the outputs list said "four Agent Events" and omitted the four run-lifecycle events; the Registers status row said "empty after a rollback" when a rollback restores the pre-run values.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A non-finite step budget deleted the loop bound - the simulator hung 30 seconds where the budget should have stopped it. Budgets are now finite by construction.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [Unreleased]
Adversarial review of the 0.1.0 candidate. Five defects, each now covered by a regression test.
- **Parser: a verb must be a whole word.** `FIRE1` used to split into `FIRE 1` and run. The allowlist claims a closed vocabulary, so a token welded to a verb is now refused under its whole name rather than quietly reinterpreted.
- **Parser: `IF` and `SET` now share one grammar.** `IF` demanded a single-token value while `SET` accepted the rest of the line, so `SET Mode Movie Night` stored a value no `IF` could ever name — writable but permanently untestable.
- **`ADD` no longer destroys a text register.** `tonumber(x) or 0` turned `Mode=Movie` into `Mode=5`. A non-numeric register now aborts the run and rolls back, which is what T8 promised all along.
- **`ADD` refuses non-finite results.** `1e400` is rejected at parse time; a sum that accumulates to infinity aborts the run. `inf`/`nan` compare false against everything and no literal can clear them, so one could permanently poison a register.
- **T8 now covers a restart mid-run.** Registers were committed to PersistData as each step ran, so a controller that died mid-run came back holding half an unfinished run's writes. The pre-run snapshot is now parked for the life of the run and restored on boot if the run never reached an ending.

## [0.1.0] - 2026-07-20
- Initial release candidate. A bounded scripted-action runner: eight Composer-authored steps over a closed verb vocabulary (SET, ADD, IF, GOTO, WAIT, FIRE, LOG, STOP), compiled by an interpreter that never evaluates dealer text.
- Safety rails, each with a regression test: fail-closed all-or-nothing parsing, a hard per-run step budget that terminates GOTO loops, single-flight execution, a stale-WAIT-timer identity check, a mid-run plan snapshot so a live script edit cannot mutate a running program, and register rollback on every abort path.
- Outputs are events and variables only — Run Started / Completed / Aborted / Script Rejected plus four Agent Events, with a rolling audit log in AGENT_LOG. The agent drives no devices, opens no sockets, and has no network trigger surface.
- Registers optionally persist across a Director restart; a run in flight never does.
