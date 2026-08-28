# Changelog — IntegrateIT Security Panel

## [0.1.1] - 2026-08-28
- The panel's own screen now ships inside the driver: a second Navigator tile opens a driver-hosted WebView (controller://, proxy 5003) that works on touchscreens and in the phone app — live partition state, arm Home and Away, disarm with code, the functions menu and the emergency row. Every command the page sends is forwarded to the same PARTITION_PROXY handlers Navigator itself calls, so the licence gate, state guards and user-code check cannot be bypassed; with no bridge present the page declares itself a preview and controls nothing.
- The security engine is unchanged — 0.1.1 is 0.1.0's engine plus the in-driver UI.

## [0.1.0] - 2026-08-27
- Initial scaffold (template: blank).
- Added a deterministic invariant fuzzer to `tests.lua` — three seeded walks over
  the whole input alphabet, asserting the six prime invariants after every input.
  It found five defects that three rounds of case-writing had not, each now
  pinned by its own named regression case:
  - a (re)bind seed report on an ARMED partition published the zone as open and
    tripped nothing, leaving the panel armed over a live open sensor;
  - a garage door reaching Open from Unknown while armed never tripped, because
    the trip demanded the door had *left* fully closed;
  - clearing an alarm judged the house with the arm-admission test, which
    excuses an Interior Follower in Home — including one the dealer had put back
    in service — and returned the partition to a quiet ARMED over it;
  - the exit-fault check had the same hole, for a follower released mid-delay;
  - turning `Open Garage On Arm` away from "Ignore" on an armed partition left
    it standing over a door it would never have armed across.
- Two more defects, both found by an adversarial round that attacked the families
  the fuzzer was written for, and both fixed here with mutation-proven cases:
  - **R4-2 (high).** An arm request could DISARM a house. `armPartition()` admits
    an already-ARMED partition, `installCycle()` then replaced the live completed
    cycle with a pending one and dropped into EXIT_DELAY — which trips nothing by
    design — and every path that gave up on the pending arm went to
    `restingState()`, never back to the arm it superseded. A nightly "Arm Away"
    schedule firing on a house that was already Armed Away therefore opened sixty
    seconds of no protection, every night; and if anything was open when the delay
    expired the house ended DISARMED with **no Disarmed event at all**, so no
    dealer rule ran and nobody's phone buzzed. Three changes: a same-mode re-arm on
    an ARMED partition is now a no-op that disturbs nothing; a cycle records the
    completed arm it displaced; and `abandonArm()` and ARM_CANCEL hand the house
    back to that arm instead of to disarmed. The invariant is "an arm request may
    never leave the house less protected than it found it".
  - **R4-1 (high).** Losing ONE of a door's two limit contacts derived MOVING — a
    positive position claim — out of a hole. `invalidateGarageReading(g, why,
    "closed")` nils only `closedRaw`; `deriveGarageState()` then saw c=nil, o=false
    and fell through to MOVING, which `evaluateGarageTrip` reads as
    positively-not-closed. Pulling a limit binding in ComposerPro on an armed house
    **sounded a burglary alarm on a door that never moved**. The door now tracks
    whether a limit was never bound (single-contact install, survivor is
    authoritative, still trips) or lost (no position claim, derives UNKNOWN, blocks
    the next arm, never sirens).
- Two new fuzzer invariants, because both defects were invisible to the six that
  shipped: **I7** — an input that cannot be an intrusion (a binding change, a
  reboot) may never sound a siren; **I8** — once ARMED, only a disarm-shaped input
  or a reboot may end it. I7 catches R4-1 at gate size in ~50 inputs. I8 is a
  long-odds net at 7,500 inputs (the round that found R4-2 needed 288,000), so the
  named regression cases, not the fuzzer, are what pin R4-2.
- I8 also caught its own author: latching only on the STATE meant `Confirm
  Disarmed`, which ends an arm while deliberately leaving the partition state
  alone, left the latch set and blamed the next input that surfaced it. The latch
  now clears on a disarming input too.
- **Press the same arm button twice to skip the countdown.** Daniel's ask, and it
  needed no new command: a second request for the mode ALREADY counting down IS
  that second press, whichever surface it came from — Navigator, a keypad, an
  experience button, a schedule. It completes through `finishArming()`, not
  straight to ARMED, so the exit-fault check still runs and an instant arm over a
  door somebody left open is refused exactly as loudly as a timed one. Entry delay
  is untouched on purpose: skipping the walk-out time must not mean walking back
  into an instant-trip front door. That completes a three-way split on one
  request — EXIT_DELAY + same mode arms now, ARMED + same mode does nothing,
  either + a different mode is a mode change with its own delay.
- The fuzzer caught the first draft of that within seconds of it landing: it fired
  `Arm Requested`, which announced an ACCEPTANCE that had not been judged. A zone
  opened between the two presses is caught by `finishArming()` so the driver was
  never unsafe, but the wire said an arm had been accepted over an open zone with
  no consent, and I1 said so at step 2379. The second press is not a new request —
  the request was made and judged at the first press — so it fires nothing, and
  what follows (Armed, or Not Ready To Arm) is the honest account.
- **N9 — a routine arm could evict the alarm from the activity log.** The ring was
  `while #gLog > cap do table.remove(gLog, 1) end`: oldest out, whatever it was.
  `installCycle()` fires one Zone Bypassed per zone whose effective bypass moved
  and `fire()` writes a ring line for each, so on a house full of Interior
  Followers ONE ordinary Arm Home wrote enough lines to bury the alarm before it —
  at the manifest minimum of 10 entries, `PRINT_ACTIVITY_LOG` showed thirteen
  lines and not one said "Alarm Triggered". Critical entries are now evicted only
  when nothing else is left to drop, so an alarm survives any amount of routine
  traffic and is lost only to a newer alarm. The dealer's chosen log size is still
  honoured exactly; only WHICH line leaves has changed.
- **N10 — free text is capped at 180 characters.** A 20,000-character `Log Note`
  produced a 20,069-character `Activity Log` property, which was then rewritten
  into PersistData on every subsequent event. A log entry is a line, not a
  document.
- Doc precision: `Zones Open` lists zones that are open **and not bypassed**, and
  the troubleshooting row no longer claims "the open zone is never hidden" —
  it is never hidden from its own tile or from `ZONE_STATE`, only from that row,
  which exists to list what would block an arm.
