# Changelog — IntegrateIT Lifestyle Buttons

## [0.1.3] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every command, action, event, variable and property name checked for a single spelling across the manifest, the code and this guide; every programming recipe rebuilt from names that actually exist; the commissioning path checked to end in something a dealer can observe; and every claim in the documentation verified against what the code does rather than what it intended.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- The runaway guard was silently deleted by a nan limit - 9 activations sailed past a limit of 8. The guard is now finite by construction.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-20
- First cut: a six-slot lifestyle mode selector on its own Navigator experience pad, plus a Reset button, with exactly one button lit at a time.
- Explicit activation and reset paths, a configurable Repeat Press policy (Ignore / Re-activate / Toggle Off), and a per-button press debounce that collapses the SELECT + DO_CLICK pair one tap can produce.
- Two independent loop guards: a re-entrancy refusal for activations raised from inside our own event dispatch, and a counting window that refuses runaway activations from any source. Both raise Activation Blocked.
- Generic Mode Activated / Mode Deactivated / All Modes Reset / Repeat Press Ignored / Activation Blocked events plus discrete Mode 1-6 Activated events; ACTIVE_MODE, ACTIVE_MODE_INDEX, PREVIOUS_MODE, MODE_ACTIVE, and LAST_CHANGE variables.
- Active mode persists across a controller restart with a Boot Mode policy of None / Restore Last / a fixed slot, restored silently unless Fire Events on Boot is set to Yes.
- Original neutral icon set (seven glyphs, one colour per mode) generated from the declarative icons spec; no themed or traced artwork.
- Adversarial review fixes before first release:
  - A boot that lands at rest no longer fires All Modes Reset under Fire Events on Boot = Yes. Nothing had been active, so it was a bind-time snapshot rather than a transition, and it ran the dealer's whole-house Reset programming on every controller restart.
  - Shrinking Modes Enabled under the active mode now checks the license gate before firing the deactivation events. The state correction still happens; only the whole-house events are withheld, so a Composer property edit can no longer run programming that Strict enforcement otherwise refuses.
  - applyState returns the real outcome instead of an unconditional true, so a throw mid-publish reports "Activation error" rather than putting a success line on Status for an activation whose icons never refreshed and whose events never fired.
  - A tripped loop guard stops counting its own refusals, so the "N activations in the window" Status stays at the number that actually ran.
  - Restore Last type-guards the persisted blob, and OnDeviceInit clears the press-debounce table, so a corrupt persist or a reload whose timers were cancelled before their callbacks ran cannot leave the driver dead or its buttons deaf.
