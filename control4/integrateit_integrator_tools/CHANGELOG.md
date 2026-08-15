# Changelog — IntegrateIT Integrator Tools

## [0.1.3] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A corrupted expiry meant a privileged authorization NEVER expired - the expiry comparison was false against nan in both directions. Authorization windows are now finite by construction.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [Unreleased] - 2026-07-20 — adversarial review fixes
- **Confirmation codes are now seeded per driver load.** Lua 5.1 starts `math.random` from a fixed sequence unless seeded, so the "one-time" code was identical on every controller and every reload — guessable without ever seeing one. Seeded from wall clock + process clock + controller MAC + a persisted nonce that bumps each boot, so two reloads inside the same second still diverge.
- **Immediate mode can no longer clear the audit log unconfirmed.** Immediate applies to the three task slots only; `Request Audit Log Clear` always arms a Two-Step confirmation. A one-Action unconfirmed wipe of the accountability record was the worst thing this driver could do.
- **Discarding a request after three wrong codes now fires `Authorization Cleared`.** It previously fired only `Authorization Denied`, leaving programming that latches pending on Requested/Cleared stuck on the one path that discards a live request.
- **Confirmation-mode and audit-webhook changes are now audited.** Weakening the confirmation regime, or retargeting the audit egress off this controller, are exactly what the trail exists to name. The webhook URL itself is not logged — it can carry a token — only that it was set, changed, or cleared.
- Catalog honesty: Immediate mode's removal of the confirmation step for task slots, and the fact that the local log dies with the driver, are now stated in `limitations`.

## [0.1.0] - 2026-07-20
- Initial release candidate: a dealer utility surface that authorizes and records privileged maintenance work
- Three project-labelled privileged tasks, each authorized as its own Control4 event; the driver performs no maintenance itself
- Three confirmation regimes (Two-Step Confirm, Code Confirm with a printed one-time code, Immediate) behind a bounded confirmation window that keeps its original schedule once armed
- Maintenance Lock that refuses every privileged request and clears anything pending; persisted across reboots
- Persistent ring-buffer audit log with an optional JSON webhook per entry plus a full-log export; clearing the log is itself confirmed and leaves a tombstone
- MAC-locked IntegrateIT licensing on every privileged path; read-only diagnostics stay available unlicensed
