# Changelog — IntegrateIT Metrics & Insights

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
