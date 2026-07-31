# Changelog — IntegrateIT SoundFX

## [0.1.4] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every command, action, event, variable and property name checked for a single spelling across the manifest, the code and this guide; every programming recipe rebuilt from names that actually exist; the commissioning path checked to end in something a dealer can observe; and every claim in the documentation verified against what the code does rather than what it intended.
- Documentation rendering: emphasis written as *emphasis* in the source now renders as emphasis in the packaged Documentation tab instead of shipping as literal asterisks. Protocol strings that legitimately contain a star, quoted inside code, stay exactly as written.

## [0.1.3] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- The queue cap comparison was defeated - the queue grew to 17 against its cap before draining.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-20
- Fixed: a room whose state could not be read was powered off at cue end. An unreadable CURRENT_SELECTION was coerced to "" and read as "the room was off", so a room that may have been playing music got a ROOM_OFF it never earned. An unread selection is now treated as unknown and the room is left exactly as found.
- Fixed: under Unlimited concurrency, two cues sharing a room left it parked at the cue volume forever. The second cue snapshotted the level the first had already set, and the first restored the room mid-playback of the second. Overlapping runs now share one inherited pre-cue snapshot, and only the run that still holds the zone restores and releases it — so the last cue out writes back the true original level, once. The persisted debt follows the same hand-off, so a restart between two overlapping holds also replays the original level.
- Limitations updated to state both behaviors plainly.

## [0.1.0] - 2026-07-20
- First cut of the audio-cue engine: six cue slots, each with its own name, media reference, and zone list.
- Room-side cue lifecycle — snapshot volume and power selection, route to the cue source, drop to the cue level, hold, then restore both.
- FIFO queue with a configurable depth and an explicit Drop Newest / Drop Oldest overflow policy; depth 0 disables queueing outright.
- Three concurrency modes: One At A Time, Per Zone (parallel while zone sets are disjoint), and Unlimited.
- A running cue carries its own resolved zones and its own snapshot, so a zone removed from configuration mid-cue is still restored.
- Owed levels are mirrored to persistent storage and replayed once at init, so a controller restart mid-cue still puts the rooms back.
- A room whose volume cannot be read still receives the cue; it is flagged with Zone Unavailable and left un-restored rather than silenced.
- Cue Started / Finished / Queued / Dropped, Queue Empty, Volumes Restored, and Zone Unavailable events plus SOUNDFX_STATE, NOW_PLAYING, CUE_MEDIA, CUE_ZONES, QUEUE_DEPTH, ACTIVE_ZONES, and LAST_CUE variables.
- Every cue path is gated on MAC-locked IntegrateIT licensing; volume restore deliberately is not, so an unlicensed controller can still unwind its own changes.
- Ships no audio: cue media is dealer-supplied and must be IntegrateIT-owned or licensed.
