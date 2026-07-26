# Changelog — IntegrateIT Shelly Cover

## [0.1.0] - 2026-07-26
- Initial release candidate. Dedicated Gen2+ Shelly Cover control over the on-device JSON-RPC 2.0 API (`POST /rpc`) — no Shelly Cloud, no issued credentials.
- Full roller/cover control the generic IntegrateIT Shelly driver cannot model: Open, Close, Stop, Go To Position (0-100), and Calibrate via Cover.Open/Close/Stop/GoToPosition/Calibrate.
- Real two-way position feedback read back from Cover.GetStatus: POSITION (0-100), COVER_STATE (open/closed/opening/closing/stopped/calibrating), MOVING, and CALIBRATED — reported by the device, never assumed. The first observed value is absorbed silently (unknown to known fires no events).
- Movement events with exactly-once semantics across duplicate/merged status frames: Motion Started / Motion Stopped, plus Fully Open / Fully Closed and Position Changed.
- Calibration honesty: an uncalibrated device (no pos_control / no current_pos) reports position as Unknown; a Go To Position the device refuses surfaces the device's own reason and raises Calibration Needed.
- Obstruction / overpower / overtemp / safety-switch faults published from the component's errors[] to LAST_ERROR, with an Obstruction Detected event on a fault transition. Safety tokens are matched on their prefix, so compound forms with a colon-delimited detail (bad_feedback:rotating_in_wrong_direction, bad_feedback:failed_to_halt) fire the event too, with LAST_ERROR carrying the full detail string.
- Polled status transport (consistent with the shipped IntegrateIT Shelly driver — the Gen2 outbound-WebSocket push is a deliberate v1 non-goal); reachability drives Went Online / Went Offline.
- Gen2+ SHA-256 digest auth gated behind an OS-crypto capability check and verified on hardware — no unexercised hash path ships; a 401 surfaces the hardware gate and the password is never logged.
- LAN-only destination safeguard (private / link-local / *.local, with an explicit Allow Non-LAN Address override); bounded backoff that honors a 429 Retry-After so the driver never hammers a rate-limited device.
- MAC-locked IntegrateIT licensing gates every actuating path, re-checked at issue time; polling continues under Strict enforcement.
- Simulation-verified via the IntegrateIT driver-factory QA gate; representative Shelly Cover hardware acceptance is pending.
