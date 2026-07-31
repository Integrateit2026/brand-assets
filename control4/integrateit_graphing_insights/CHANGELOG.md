# Changelog — IntegrateIT Metrics & Insights

## [0.1.3] - 2026-07-31
- Programming-recipe honesty (per research/briefs-2026-07-26/actions-vs-commands-verdict.md, interim rule): the recipe "on a scene or door event -> call Record Sample Now" fired an Actions-tab entry from programming, which this driver declares no command for. Replaced with a Sample Recorded event recipe; the Actions-tab entries are now labelled as the dealer pokes they are, with Record Sample Now's behaviour kept.
- The guide documented no events at all: ten are declared and fired, but only a few were named in passing prose and Sample Recorded was never mentioned. Programming could not be written against events a dealer could not find. Adds the full event table, including which events are edge-triggered (Source Unavailable fires once per outage, Retention Limit Reached once per ring).
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- Non-finite inputs crashed rendering with 'table index is NaN' and a bad format specifier; both paths are now guarded.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [Unreleased]
Adversarial review pass over the first cut. Five defects, each with a regression case.

- The window no longer collapses when the open hour is sealed. Under Aggregates Only there are no raw rows by construction, so the window came from the open hourly bucket alone — and `Seal Open Buckets` nils it, dropping min/max/average/trend to zero on a ledger still holding good data. It now falls back to the newest sealed hour.
- The cascade is explicitly append-only. A sample stamped older than the newest hour the ledger holds used to seal the open hour and reopen a past one, which the next live sample sealed again: two rows for one hour, an hourly ring out of chronological order (so both the export and `METRIC_DELTA_1H` read the wrong row), a spurious `Hour Rolled Over`, and a `Current Value` walking backwards. Stale instants are refused now, and the limitation is documented.
- `Storage Estimate` billed for the raw sample ring whenever persistence was `Full`, even though privacy outranks persistence in `savePersist` and a `Full` + `Aggregates Only` project stores no raw rows at all. The estimate overstated the backup footprint by the whole sample ring.
- Restored persistence rows are validated, not merely type-checked. "Is a table" was the entire test, so a table-shaped row missing its numeric fields entered the ring and then threw on the first arithmetic that touched it — taking down the next `RecordSample` and leaving a live driver with a dead ledger. Buckets and samples are now field-validated, and `total` is clamped.
- Tightening Privacy Mode rebuilds the recent ring empty but left the wrap flag set, silently retiring `Retention Limit Reached` for the rest of the driver's life. Fresh headroom re-arms it, as it already did on a retention resize.

## [0.1.0] - 2026-07-20
- First cut of the bounded metric ledger: a three-tier cascade (raw samples into an open hourly bucket, sealed hours folded into an open daily bucket) with a fixed-capacity ring behind each tier, so both memory and project-backup footprint are capped by configuration.
- Local-calendar bucket keys rather than epoch arithmetic, so a daylight-saving day is still exactly one day; a repeated fall-back hour merges into its open bucket instead of duplicating or resurrecting a sealed one.
- Insight surface: `METRIC_VALUE` / `METRIC_MIN` / `METRIC_MAX` / `METRIC_AVG` / `METRIC_TREND` / `METRIC_DELTA_1H` / `SAMPLE_COUNT` / `LAST_SAMPLE_AT`, plus events for new extremes, significant change, hour and day rollover, source loss, retention wrap, clear, and export.
- Privacy Mode (Full History / Aggregates Only / Paused) outranks Persist Across Reboot (Off / Aggregates Only / Full); tightening privacy retroactively discards raw rows already held. `Storage Estimate` reports the ceiling a configuration can reach in a project backup.
- CSV and JSON export, capped at 500 rows and truncated oldest-coarse-first, to the Lua output window or an HTTP endpoint; a rejected send is reported and dropped rather than retried.
- Licensing: every control path (record, seal, export, clear) is behind `LicenseGate()`.
- Release Candidate, simulation-verified. No representative hardware acceptance yet.
