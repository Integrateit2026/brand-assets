# Changelog — IntegrateIT Hue Bridge

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A non-finite brightness could ship {"brightness":nan} to the bridge - not JSON, whole PUT rejected.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-27
- Brightness feedback now follows the right light. The bridge sends object keys in alphabetical order, which the old parser mis-sliced - with several lights in one read each picked up its neighbour's level (10/55/99 arrived as 55/99/blank) and the last got none.
- Dims made from the Hue app, a wall dimmer, or an accessory are now seen live. A dim-only eventstream update previously parsed as nothing, so SLOT_n_BRI only moved when Control4 itself sent the command.
- A bulb's power-restore default no longer masquerades as its current brightness - the driver reads only the resource's own top-level dimming value, never the nested powerup block.
- Eventstream frames are accepted with CRLF and bare-CR line endings, not just LF. A bridge or proxy using CRLF previously left the driver silently deaf - connection up, status Online, every state change discarded.
- Lights, rooms, and scenes named with brackets or braces no longer truncate a read or vanish from the scene list; names reach LAST_SCENE exactly as typed in the Hue app.
- Resource parsing is now order-independent and string-aware by construction, with regression coverage in both the bridge's real key order and the reverse.

## [0.1.0] - 2026-07-26
- Initial release candidate: local Control4 control of a Philips Hue Bridge over the on-bridge CLIP API v2 (HTTPS, developers.meethue.com). Clean-room original engineering.
- Link-button pairing built in: Pair (Link Button) POSTs `/api` with `generateclientkey`, handles the error-101 "press the button" round-trip, and stores the returned application key in the password-typed property — never printed, never logged (it rides only in the `hue-application-key` header).
- Up to eight slots, each mapped as `light:<rid>` / `group:<rid>` / `scene:<rid>` by CLIP resource id: Slot On/Off/Toggle, Set Brightness (0-100, 0 = off), Set Color Temperature (mirek 153-500), Set Color (CIE xy, clamped), and Recall Scene via PUT /clip/v2/resource/….
- Push feedback: consumes the /eventstream/clip/v2 SSE stream and reflects changes into BRIDGE_ONLINE, per-slot SLOT_n_ON / SLOT_n_BRI, LAST_CHANGED_SLOT, and LAST_SCENE without polling; fires Slot Turned On/Off, Bridge Online/Offline, Scene Recalled, and Event Stream Reconnected. SSE parsing tolerates arbitrary chunk boundaries and keep-alive comments.
- Self-healing: on a stream drop it reconnects with bounded backoff (5s → 60s cap) and runs one full resync; a periodic resync heartbeat backs the stream up and is the whole feedback path on legacy OS builds without C4:url streaming.
- Honest TLS trust model: the bridge is self-signed, so the driver connects over HTTPS with CA verification disabled and pins trust to the LAN address + application key; a broken TLS handshake fails closed and never downgrades to plaintext.
- LAN-only destination guard with an Allow WAN Bridge override, a single bounded retry that honors 429 Retry-After (no retry storm), and MAC-locked IntegrateIT licensing on every control path.
- Known limits: no entertainment/streaming API and no accessories (motion/buttons/sensors) yet — lights, grouped_lights, and scenes only; eight slots per instance; commands act on the Target Slot property.

### Fixed (pre-ship verify)
- Scene slots no longer fake power events from the eventstream. A scene resource pushed over `/eventstream/clip/v2` carries its own `actions[].action.on`/`dimming`, which the tolerant extractor reads out under the scene's rid; `SlotForRid` resolves that to the scene slot, so the driver was firing phantom `Slot Turned On/Off` and flipping `SLOT_n_ON` off a scene's action list (the resync path was safe via `captureScenes`; only the live stream bit). `ApplyResourceUpdate` now reflects light/group slots only — scene rids, unmapped resources, and the SSE envelope's own event id are dropped, which also bounds `gState` to the ≤8 mapped light/group rids instead of growing one dead entry per stream event over the controller's uptime. New runtime case `a scene update over SSE never fakes a slot power event` covers the live-stream path.
