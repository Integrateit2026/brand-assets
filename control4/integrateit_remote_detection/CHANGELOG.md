# Changelog — IntegrateIT Remote Detection

## [0.1.0] - 2026-07-20
- First cut. Classifies which handheld remote is driving a room across six explicitly bounded classes (SR-250, SR-260, Halo, Halo Touch, Neeo, Other Remote), fed by six BUTTON_LINK connections and/or the Report Remote Activity programming command.
- Duplicate-press suppression on a guard timer, stale-activity timeout, per-class offline/reconnect tracking, reported battery level with a low-battery threshold, and a three-position Privacy Mode (Full Detail / Class Only / Off).
- Last class, seen list, and detection count survive a Director restart via PersistData; the active remote deliberately does not, and the restored class re-confirms with a Remote Reconnected event on its next press.
- An unrecognized CLASS token raises Unrecognized Remote Reported and is never coerced onto a supported class.
- Adversarial review fixes before first release: Remote Reconnected is now strictly per class (a first-ever press in a quiet room was firing a reconnect for a remote that had never been connected); offline and stale marks are persisted so they survive a restart as the catalog claims; Clear Detection clears the pending reconnect; and every class's own published display name — including "Other Remote" — now round-trips as a CLASS parameter instead of landing on Unrecognized.
