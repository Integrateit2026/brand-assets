# Changelog — IntegrateIT Network Agent

## [0.1.0] - 2026-07-20
- First cut: bounded LAN reachability diagnostics for 1-6 explicitly allowlisted peers.
- IIT-NA/1, an original single-frame probe protocol — the driver can only ever emit PING, so there is no remote command channel, shell, or discovery path.
- Authenticated probes: a base64 shared-secret token on every frame, and a reply is accepted only when the protocol tag and the in-flight probe sequence both match.
- LAN-only destination guard with canonical-IPv4 parsing (non-canonical octets, numeric hosts, routable FQDNs, and IPv6 refused), overridable per-install by Allow WAN Peers.
- Per-minute probe budget with a Probe Rate Limited event; a bounded 512-byte inbound buffer; redacted address logging by default and a shared secret that never reaches the log.
- Verdicts: Reachable, Degraded (answered past the slow threshold), Reachable-connect-only (host accepts TCP but does not speak IIT-NA/1), Unreachable. Sweeps raise Probe Sweep Complete and All Peers Reachable.
- Cumulative probe statistics persisted across controller reboots, resettable from the Actions tab.
- Release Candidate, simulation-verified. Representative peer acceptance on a controller is still pending.

### Fixed during adversarial review
- A settling probe closes its own socket, and the controller reports that close as OFFLINE a moment later. That OFFLINE was landing on the NEXT probe and settling a perfectly reachable peer as Unreachable — a false negative on every second consecutive probe, with no peer involvement at all. The driver now owns the close it asked for and refuses to read it as evidence; a genuine drop still settles immediately.
- Changing the Agent Port while a probe was in flight left the old probe running and filed its timeout verdict against the new port. It is now withdrawn, like an address change already was.
- Switching Allow WAN Peers back to No left an already-launched off-LAN probe on the wire until its timeout. The destination guard now bites the moment it is switched on.
- An mDNS name typed in mixed or upper case ("Rack-Switch.LOCAL") was refused as a routable internet host. DNS labels are case-insensitive and the suffix test now is too.
- Documented two real limitations that were missing: verdicts (unlike the statistics) do not survive a reboot, and a mid-probe reconfiguration withdraws the probe without a verdict.
