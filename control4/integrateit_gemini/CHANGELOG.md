# Changelog — IntegrateIT Gemini Assistant

## [0.1.4] - 2026-08-15
- Certification pass: the packaged Version history now renders its formatting instead of shipping raw markdown, plus documentation corrections verified line by line against the driver's own manifest and code.

## [0.1.3] - 2026-07-30
- A numeric property containing nan or inf (possible through a hand-edited project file) passed tonumber, defeated every range clamp (all nan comparisons are false), and could reach a timer interval or the wire. Numeric properties now fall back to their documented default when non-finite, and the transmit chokepoint refuses a non-finite value by name.
- A non-finite token limit could ship maxOutputTokens:nan inside a BILLABLE request body.
- Adds the fleet-standard Run Diagnostics and Run Self-Test dealer actions: read-only, license-independent, cached-state honesty. Diagnostics reports what the driver has already observed - never probing the network, never printing a secret. Self-Test proves the shared layer locally and ends PASS or FAIL.

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-21
- Honest empty-answer handling: an output-side safety/policy block (a candidate returned with finishReason SAFETY / RECITATION / BLOCKLIST / PROHIBITED_CONTENT / SPII / IMAGE_SAFETY and no text parts) now surfaces as "blocked by safety filter (<reason>)" instead of a generic "empty response". Previously only a prompt-level block (promptFeedback.blockReason) was named; a censored *answer* read as a bland empty response and looked like a network fault.
- A thinking model that spends its whole token budget before emitting any text (finishReason MAX_TOKENS with no parts) now reports "hit the Max Response Tokens cap; raise it" rather than "empty response", so the fix is obvious. All of these still fail closed with a Request Failed event and never land text in RESPONSE.

## [0.1.0] - 2026-07-20
- Initial release: bring-your-own-key cloud driver for the official Google Gemini API (v1beta unary generateContent).
- Ask Gemini command sends the Prompt with an optional System Instruction and a Max Response Tokens cap; the bounded answer (4000 chars) lands in the RESPONSE variable with Response Received / Response Truncated / Request Failed events.
- Request timeout with a stale-response guard, busy + min-interval rate guard, hard model-name allowlist (no URL injection), and the API key confined to the x-goog-api-key header — never logged, never in a URL.
- Test API Key action verifies key + model + egress via model metadata without consuming tokens.
