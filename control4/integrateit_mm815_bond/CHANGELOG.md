# Changelog — MantelMount MM815 (Bond Bridge)

## [1.5.6] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [1.5.5] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [1.5.4] - 2026-07-16
- Navigator presses accept DO_CLICK as well as SELECT so the PTZ buttons respond on every OS build
- Icons packed at both c4z roots so the PTZ buttons and device icon render; discovery probe fan-out capped at 8
- Init errors surface in the Status property instead of failing silently

## [1.5.3] - 2026-07-14
- Adds schema v3 release evidence, compatibility, limitations, and a packaged documentation screenshot.
- Refreshes the shared IntegrateIT commissioning guide and release pipeline without changing bindings.

## [1.5.2] - 2026-07-05
- resync channel bytes after iit_update.lua channel-comment fix

## [1.5.1] - 2026-06-18
- OTA self-update validation build. Identical code to 1.5.0.

## [1.5.0] - 2026-06-18
- TV-follow: new Deploy / Stow commands — wire Deploy to TV/room ON to lower the TV to the Viewing
  Position, Stow to OFF to raise it to the wall. New "Viewing Position" property picks which favorite.
- New POSITION_STATE, IS_MOVING variables (for programming) + Deployed / Stowed events that fire once
  the mount has had time to travel (Move Settle Time).
- Favorites 3-6: Memory 3-6 Command properties + Go Favorite 3-6 commands.
- Smart install + health: Discover Bond Bridges action (scans the controller subnet so you don't
  hand-find the IP), Bond health polling with an Online/Offline status + BOND_ONLINE variable and
  Bond Online / Bond Offline events.
- OTA self-update validation build. Identical code to 1.4.4.

## [1.4.4] - 2026-06-18
- Bond HTTP now reports the real error code. C4:url()'s fail_on_error defaults to true, which
  collapses a 401 (wrong Local Token) or 404 (wrong Device ID) into "HTTP 0"; set fail_on_error=false
  so Test Connection / List Commands and the button error status show the actual code + Bond body.
- (Sixth adversarial SDK-audit pass.)

## [1.4.3] - 2026-06-18
- OTA self-update validation build. Identical code to 1.4.2; bumped so an installed 1.4.2 shows a
  pending update you can exercise via Download & Stage > Update Driver.

## [1.4.2] - 2026-06-18
- Moved `<events>` to a top-level `<devicedata>` child (it was nested in `<config>`, where it may
  not register) so the Update Available / License Problem events fire for dealer programming.
- (Second adversarial SDK-audit pass.)

## [1.4.1] - 2026-06-18
- OTA self-update validation build. Identical code to 1.4.0; bumped so an installed 1.4.0 shows a
  pending update you can exercise via Download & Stage > Update Driver.

## [1.4.0] - 2026-06-18
- Removed `<combo>true</combo>`. A combo driver tells Director it has NO Control4 proxy and gets no
  Navigator UI — wrong for a 9-button uibutton driver. The control buttons now render in Navigator.
- Device tile icon now resolves in Composer (image_source="c4z", packaged under www/icons/).
- (Found by an adversarial audit against the DriverWorks SDK.)

## [1.3.1] - 2026-06-18
- Over-the-air self-update validation build. Functionally identical to 1.3.0; bumped so an
  installed 1.3.0 shows a pending update and you can exercise Download & Stage > Update Driver.

## [1.3.0] - 2026-06-18
- License gate is now Lenient by default — the mount works the moment it is wired,
  and License Status nags for activation. Set License Enforcement = Strict to hard-gate.
- Self-update now stages the new .c4z with the real DownloadFile API (subdir C4Z) instead
  of a sandboxed file write that never landed. Finish with right-click > Update Driver.
- Faster first update check after boot (15s) so a pending update surfaces quickly.

## [1.2.1] - 2026-06-07
- Default relay endpoints now point at integrateit.dev (the live Cloudflare-hosted relay).
- Rebuilt on the IntegrateIT driver factory (shared licensing + self-update runtime).

## [1.2.0] - 2026-06-07
- Added MAC-locked licensing: one key per controller, managed in the Ops Portal.
- Self-update channel: flags "Update Available" and stages the new build for Composer.

## [1.1.0] - 2026-06-07
- Drive-to-limit (Run + arrow) latched movement, Home / Favorite 1 / Favorite 2.
- True hold-to-move via keypad PRESS/RELEASE programming commands.

## [1.0.0] - 2026-06-07
- First build: 9-button control pad over Bond Bridge local API, nudge + stop.
