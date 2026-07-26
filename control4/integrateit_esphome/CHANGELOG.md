# Changelog — IntegrateIT Client for the ESPHome Native API

## [Unreleased]
### Fixed
- Re-baseline a slot when its binding changes. A runtime edit to a Slot n Entity
  property (or a rebind after re-enumeration) previously rebound the slot's key
  but kept the PREVIOUSLY bound entity's known-state, cached display, typed
  variables, and State property. Two consequences on hardware: SLOT_n_BOOL /
  SLOT_n_NUMBER kept driving automation with the old entity's value under the new
  entity's identity until the new one happened to report, and the new entity's
  first reading fired a phantom Slot n Changed — breaking the documented
  baseline-silence guarantee. resolveSlots now detects a changed binding and
  resets that slot to unknown (clearing its variables and State) so the new
  entity's first reading is a silent baseline; slots whose binding is unchanged
  are left untouched, so re-resolving after an unrelated property edit never
  swallows a real pending change.

## [0.1.0] - 2026-07-26
- Initial release candidate: a clean-room Control4 client for the ESPHome Native
  API, speaking the plaintext-framed protobuf wire protocol directly over TCP
  (default port 6053) with a hand-rolled minimal codec — no third-party library.
  Specified from ESPHome's public docs (esphome.io/components/api.html,
  developers.esphome.io/architecture/api and .../protocol_details) and the public
  api.proto message-id / field annotations.
- Handshake: HelloRequest/HelloResponse, then ConnectRequest with the optional
  legacy plaintext password and ConnectResponse (invalid_password surfaces a
  Password Rejected event with no retry storm), DeviceInfoRequest, a full
  ListEntities enumeration, and SubscribeStates.
- Entities: switch, binary_sensor, sensor, and text_sensor are enumerated and
  summarized in Entities Found. Up to eight are mapped by object id or key hex
  into labeled slots, each publishing SLOT_n_STRING / SLOT_n_NUMBER / SLOT_n_BOOL
  variables and a Slot n Changed event. The unknown-to-first-known transition
  updates the variables but fires no event.
- Control: switch slots expose On / Off / Toggle, each gated on the license at
  dispatch and re-checked immediately before the wire write.
- Resilience: keepalive Ping every interval with a three-missed-reply reconnect,
  bounded-backoff reconnect, entity re-enumeration on reconnect, a reassembly
  parser tolerant of arbitrary chunk boundaries and unknown message types, and a
  capped RX buffer.
- Honest v1 boundary: PLAINTEXT + LEGACY PASSWORD ONLY. A device with an api:
  encryption key (Noise) refuses plaintext; the driver detects the refusal frame
  and reports "This device requires API encryption; disable the key or wait for
  v2." rather than retrying. No Noise/ChaCha20 in v1.
- Safety: LAN-only destination guard with an Allow WAN Destinations override, a
  password-typed credential that is never printed or logged, Debug that logs
  frame type + byte count only (never payload content), and MAC-locked
  IntegrateIT licensing.
