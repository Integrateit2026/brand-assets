# Changelog — IntegrateIT Generic TCP Toolkit

## [0.1.0] - 2026-07-16
- First release candidate. Original IntegrateIT raw-TCP client for Control4.
- Four labeled command slots plus a raw-payload send, all fireable from Composer programming.
- ASCII/UTF-8 or hex-byte payloads with selectable CR / LF / CR+LF line endings.
- Persistent socket with backed-off auto-reconnect, or on-demand connect-per-send.
- Connected / Disconnected / Response Received / Connection Failed events; DEVICE_ONLINE + LAST_RESPONSE variables.
- Safety: LAN-only destinations by default (WAN opt-in), outbound payload size cap, bounded response buffer, audit logging.
- MAC-locked IntegrateIT licensing with lenient (default) or strict enforcement.
- Simulation verified; representative device acceptance on a controller is still pending.
