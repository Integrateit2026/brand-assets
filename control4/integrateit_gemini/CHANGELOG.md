# Changelog — IntegrateIT Gemini Assistant

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
