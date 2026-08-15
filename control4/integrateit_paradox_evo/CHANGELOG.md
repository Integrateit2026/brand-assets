# Changelog — IntegrateIT Paradox EVO

## [0.1.3] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-21
- Pre-ship adversarial review hardening (state fidelity + the never-suppress-an-alarm contract), no protocol changes:
  - Special disarm events (system-event group G022 - WinLoad disarm, one-touch stay/instant disarm, voice-module disarm, auto-arm cancelled) now report the area as Disarmed and fire `Area Disarmed`. These paths emit no G013-018 disarm event, so G022 is their only signal; previously the area read a stale `Armed` until the next status poll. The G022 cancel-alarm sub-event (N004) still only clears the alarm and never fabricates a disarm.
  - A zone/fire/panic alarm whose area field is 000 (all-areas / global) is no longer silently dropped: it still fires `Area In Alarm` and surfaces status, upholding the driver's standing contract that an alarm is never suppressed even when it has no single area to pin it to.
  - Added regression tests: G022 special disarm (and the N004 non-disarm guard), global-area alarm never suppressed, an RA reply reassembled from byte-at-a-time serial chunks, and a NACKed (&fail) arm that must never fabricate an armed state.

## [0.1.0] - 2026-07-21
- Initial release: two-way Paradox Digiplex/EVO bridge per the published APR3-PRT3 ASCII serial protocol - license-gated area arm (Regular/Force/Stay/Instant), quick arm, and disarm for areas 1-8; pushed zone open/close events; per-area status variables; trouble events with the documented descriptors; PRT3 panel-link supervision; paced transmit queue honoring the PRT3 buffer-full backpressure. Convenience integration only - NOT a listed alarm path; the driver never auto-disarms, and the panel user code is never logged, never placed in a variable, and masked in every display.
