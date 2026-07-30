# Changelog — IntegrateIT Lutron HomeWorks QS

## [0.1.2] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A corrupted level could reach the RS-232 wire as #OUTPUT,n,1,50,nan - the processor rejects the line and the keypress does nothing.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.1] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.0] - 2026-07-21
- Initial release: Lutron Integration Protocol (LIP) telnet client for classic HomeWorks QS processors (HQP6-x / HQP7), built against Lutron's published protocol reference (P/N 040249).
- Prompt-based telnet login (login: / password: / session prompt) with installer-provisioned credentials from Lutron Designer; a rejected login latches instead of retrying.
- Control of up to 8 mapped OUTPUT integration IDs: Set Zone Level (action 1, with fade), Raise / Lower / Stop (actions 2 / 3 / 4).
- Zone monitoring asserted at login (#MONITORING,5,1) plus a per-zone prime query; live per-zone level variables, LAST_ZONE / LAST_ZONE_LEVEL, and a Zone Level Changed event.
- Reconnect with exponential backoff (base delay doubling to 5 min, reset on login); connect and login watchdogs; bounded pre-login command queue.
- Guarded raw LIP escape hatch (system-level verbs refused); credentials never written to the Control4 log; ~ERROR replies decoded into a Protocol Error event.
- Login hardening (pre-ship review): a password prompt that arrives AFTER the password was already answered is now treated as a rejection and latches — the same guarantee the "login:" re-prompt already gave — so a wrong password can never be resent in a loop that risks locking the Lutron telnet account.
- Login hardening (pre-ship review): the unterminated-tail prompt detector now requires that authentication has begun before it accepts a "…>" prompt as logged-in, matching the glued-prompt line path; a stray ">"-terminated banner arriving before "login:" can no longer spoof a Connected session and then latch a false Login Failed when the genuine prompt arrives.
