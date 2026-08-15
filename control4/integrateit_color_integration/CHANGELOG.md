# Changelog — IntegrateIT Color Integration

## [0.1.4] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.3] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every command, action, event, variable and property name checked for a single spelling across the manifest, the code and this guide; every programming recipe rebuilt from names that actually exist; the commissioning path checked to end in something a dealer can observe; and every claim in the documentation verified against what the code does rather than what it intended.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A poll timer could arm with a nan interval and never fire; it now falls back to its documented default.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-20
- First cut of the color engine. Original color-space specification and Control4
  light-proxy mapping: four input forms (RGB hex, HSV, Kelvin, CIE xy) normalized
  to a CIE 1931 chromaticity plus a Full Color / Color Temperature mode.
- Gamut mapping into sRGB, a Rec.2020-style wide triangle, or clamp-only, with
  out-of-gamut requests projected to the closest point on the gamut boundary and
  a `Color Clamped` event rather than a dropped request.
- Configurable Kelvin floor/ceiling; requests outside it are pulled to the
  nearest reachable white and reported as clamped.
- Bounded transitions (max 120 published steps) with mired interpolation between
  two color-temperature endpoints and xy interpolation everywhere else; the final
  step publishes the exact target. `Cancel Transition` holds the reached step.
- Warmer / Cooler Kelvin nudges, instant apply, auto-apply on input change, and a
  silent re-map when gamut or Kelvin bounds are edited live.
- Last applied color persists across a controller reboot and is republished at
  boot without firing events.
- Every control path gated on `LicenseGate()`.

### Adversarial review fixes (pre-release, same 0.1.0 cut)
- `remapCurrent` (the live Gamut / Kelvin-bound edit) is a control path — it
  republishes the color and fires `Color Applied` — but was NOT gated. A
  Strict-unlicensed controller could be driven from the Gamut dropdown even
  though `Apply Color` was correctly blocked. Now gated.
- A live Gamut / Kelvin edit DURING a fade cancelled the ramp and stranded the
  light on whatever intermediate color it had reached; the requested color never
  arrived. The ramp is now re-aimed through the new constraints (both endpoints
  re-mapped, so every remaining step stays inside the new triangle) and runs to
  completion.
- A re-map that landed on the already-published color wrote `COLOR_CLAMPED = 0`,
  so an unrelated Kelvin-bound nudge silently cleared a clamp flag that was still
  true and handed programming a false "in gamut". The no-op path is now genuinely
  silent, as documented.
- The boot restore republished the persisted color verbatim. If the gamut or
  Kelvin window was narrowed while the controller was down, that put an
  unreachable chromaticity on the variables and reported it as in gamut. The
  restore is now re-mapped through the current constraints, with the clamp state
  recorded silently (still no events).
- `Clamp Only` clamped x and y independently and so accepted impossible
  chromaticities: x + y > 1 implies a negative z, and (0.9, 0.9) sailed through
  unflagged into the XYZ->RGB matrix, which fabricated a hex for a color that
  does not exist. The point is now projected onto the CIE simplex edge
  (x + y = 1) and flagged as clamped.
