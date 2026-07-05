# Changelog — IntegrateIT Optimus AI

## [2.3.3] - 2026-07-05
- resync channel bytes after iit_update.lua channel-comment fix

## [2.3.2] - 2026-07-03
- Navigator button press (SELECT) now re-pushes the current app URL and refreshes the in-app snapshot — a stale Navigator heals on tap (a declared uibutton proxy previously had no ReceivedFromProxy handler).
- Test Event / Test Announcement actions are now license-gated like every other control path (Strict + unlicensed fires no device events).

## [2.3.1] - 2026-06-18
- OTA self-update validation build. Identical code to 2.3.0.

## [2.3.0] - 2026-06-18
- Expanded AI control: the assistant can now drive thermostat (warmer/cooler/heat/cool/off/auto and
  set-temperature via the LAST_SETPOINT variable), shades (open/close/stop), fans (on/off/higher/lower),
  any named scene (Custom Scene + LAST_SCENE variable), and announcements (Announcement Requested +
  ANNOUNCEMENT_TEXT variable) — all as new events a dealer wires to real devices/scenes. Per-room
  targeting via the LAST_ROOM variable.
- Deeper integration: resilient polling with exponential backoff (5s..60s) while the relay is
  unreachable + a Relay Connection status and RELAY_STATUS variable; a WebView JS bridge so the in-app
  UI can drive Control4 directly (APP_ACTION / APP_REFRESH) and receive live state (SendDataToUI);
  optional two-way device state (configure Lock / Thermostat Device ID to include their live variables
  in the relay push).
- OTA self-update validation build. Identical code to 2.2.10.

## [2.2.10] - 2026-06-18
- Relay/license HTTP now reports the real error code (set C4:url() fail_on_error=false), so a 4xx/5xx
  from the relay surfaces its status + body instead of collapsing to "HTTP 0".
- (Sixth adversarial SDK-audit pass.)

## [2.2.9] - 2026-06-18
- OTA self-update validation build. Identical code to 2.2.8.

## [2.2.8] - 2026-06-18
- Hardened the relay JSON parser against an infinite loop on a truncated/unterminated response.
  PollRelay parses the relay body every ~2s; an unterminated string (dropped connection, 4MB-cap
  truncation, relay bug) spun the parser forever and wedged the driver's Lua thread until reboot
  (pcall can't break an infinite loop). All parser loops now raise on end-of-input so json.decode
  returns nil and the poll safely no-ops. Verified under LuaJIT against the exact hanging inputs.
- (Fifth adversarial SDK-audit pass.)

## [2.2.7] - 2026-06-18
- OTA self-update validation build. Identical code to 2.2.6.

## [2.2.6] - 2026-06-18
- Removed the garage-door CONTACT_SENSOR bindings (301/302) and their handler. A generic driver
  cannot reliably consume an external contact's open/closed via ReceivedFromProxy (that entrypoint is
  for proxy/type-2 bindings, not type-1 control bindings) — so this shipped only verified-correct
  mechanisms rather than a binding that may silently never fire. Garage-state feedback, if wanted, is
  a hardware-verified follow-up via a stock contact driver + watched variable.
- (Fourth adversarial SDK-audit pass.)

## [2.2.5] - 2026-06-18
- OTA self-update validation build. Identical code to 2.2.4; bumped so an installed 2.2.4 shows a
  pending update you can exercise via Download & Stage > Update Driver.

## [2.2.4] - 2026-06-18
- Lock action now fails SAFE: a relay/AI `lock` command missing its `locked` boolean is a no-op
  instead of silently firing Unlock (previously `nil and 40 or 41` → 41 = Front Door Unlock, also
  bypassing the sensitive-action gate). Same explicit-boolean guard on the garage branch.
- JSON encoder escapes all control characters (\\b \\f and \\u-escapes the rest) so a state push is
  always valid JSON.
- (Third adversarial SDK-audit pass.)

## [2.2.3] - 2026-06-18
- OTA self-update validation build. Identical code to 2.2.2; bumped so an installed 2.2.2 shows a
  pending update you can exercise via Download & Stage > Update Driver.

## [2.2.2] - 2026-06-18
- Moved `<events>` to a top-level `<devicedata>` child (it was nested in `<config>`, where it may
  not register) so the driver's scene/lights/lock/garage events fire for dealer programming.
- (Second adversarial SDK-audit pass.)

## [2.2.1] - 2026-06-18
- OTA self-update validation build. Identical code to 2.2.0; bumped so an installed 2.2.0 shows a
  pending update you can exercise via Download & Stage > Update Driver.

## [2.2.0] - 2026-06-18
- Removed `<combo>true</combo>` (a combo driver gets no Navigator UI) so the Optimus AI button renders.
- Garage-door contacts now actually update: the old `CONTACT_CHANGED` was never a DriverWorks
  entrypoint, so garage state was frozen. Replaced with `ReceivedFromProxy` handling OPENED/CLOSED
  (and STATE_OPENED/STATE_CLOSED on bind) for contact bindings 301/302.
- Poll/state timers now cancel correctly via the shared named-timer helpers — they were created with
  `C4:SetTimer` but torn down with `C4:KillTimer`, which leaked timers and stacked duplicate poll loops
  on every reconfigure.
- Device tile icon now resolves in Composer (image_source="c4z").
- (Found by an adversarial audit against the DriverWorks SDK.)

## [2.1.1] - 2026-06-18
- Over-the-air self-update validation build. Functionally identical to 2.1.0; bumped so an
  installed 2.1.0 shows a pending update and you can exercise Download & Stage > Update Driver.

## [2.1.0] - 2026-06-18
- Fixed the relay transport: every call used C4:urlGet with an inline callback, which the
  API ignores — so polling, state push, Test Relay and snapshots silently never ran. All
  HTTP now goes through the shared dispatcher.
- Fixed two hard crashes: C4:UrlEncode does not exist (now a real RFC-3986 UrlEncode), and
  events fired with C4:FireEvent(number) instead of C4:FireEventByID.
- WebView now declared correctly (web_view_url is a capability, not a proxy child) and the
  per-site app URL is pushed at runtime via URL_CHANGED, so the app actually opens.
- License gate Lenient by default (control enabled, status nags); Strict still available.
- Self-update stages the new .c4z via the real DownloadFile API.

## [2.0.0] - 2026-06-07
- Migrated onto the IntegrateIT driver factory: shared design, polished docs, and the
  standard self-update channel (static version.json on relay.integrateit.dev).
- Added per-controller license-key activation, managed in the Ops Portal — the app shell
  still loads when unlicensed, but the driver will not drive Control4 actions until a valid
  key activates. (The Site Token remains for relay routing.)
- Default relay endpoints now point at integrateit.dev.

## [20260607] - 2026-06-07
- Optimus AI app + Service Requests + My System inside Navigator (webview), relay polling,
  state push, camera snapshot, garage-contact awareness, MAC-bound site licensing.
