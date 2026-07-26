# Changelog — IntegrateIT OpenAI Assistant

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-21
- Input spend guard: added a per-prompt character cap (Max Prompt Characters,
  default 8000, 100–100000). An Ask whose prompt exceeds the cap is failed with
  Request Failed BEFORE the spend-window count and any network call. The
  max_completion_tokens cap only ever bounded the answer, so a runaway scene
  that concatenated a huge variable could have shipped a large input-token
  charge to the customer's account on every Ask — this bounds the request too.
- Honest server-side truncation: when OpenAI stops at max_completion_tokens
  (finish_reason "length") the answer is cut off mid-thought. The driver still
  fires Response Ready and publishes what came back, but Status now reads
  "truncated at token cap — raise Max Response Tokens" instead of presenting a
  partial answer as if it were complete. With the 256-token default this is a
  common case, not an edge one.

## [0.1.0] - 2026-07-20
- Initial release: non-streaming chat-completions Ask path against the official
  OpenAI Platform API (POST /v1/chat/completions, bearer-key auth).
- Ask command (PROMPT parameter or Prompt property) with configurable model,
  system prompt, and max_completion_tokens cap; answer published to a bounded
  RESPONSE variable with a Response Ready event.
- Strict per-request timeout with stale-response discard; Request Failed and
  Rate Limit Reached events; LAST_ERROR variable.
- Spend guard: rolling one-hour request cap enforced before any network call;
  one request in flight at a time; Requests This Hour visibility.
- BYO-key design: the end customer's own API key in a password property, sent
  only in the Authorization header, never logged, never placed in a variable.
- Test API Key action via the free GET /v1/models endpoint.
