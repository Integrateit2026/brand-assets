#!/bin/bash
# Deploy the latest IntegrateIT driver catalog to the relay.
# RUN THIS ON THE MAC THAT HOSTS relay.integrateit.dev (the Mac Mini).
# It replaces the Ops Portal driver-catalog page with the new self-syncing one
# (reads the live update channel, so it can never go stale again) and refreshes
# the relay's local driver store from the channel. Idempotent — safe to re-run.
set -uo pipefail
CH="https://raw.githubusercontent.com/Integrateit2026/brand-assets/main/control4"
echo "=============================================================="
echo " IntegrateIT — deploy latest driver catalog to the relay"
echo "=============================================================="

# 1. locate the relay (public/ops/drivers.html)
RELAY=""
for d in "$HOME/optimus-relay" "$HOME/Desktop/optimus-relay" \
         $(find "$HOME" -maxdepth 5 -type d -name optimus-relay 2>/dev/null); do
  if [ -f "$d/public/ops/drivers.html" ]; then RELAY="$d"; break; fi
done
if [ -z "$RELAY" ]; then
  echo "!! Could not find the relay (no public/ops/drivers.html under your home)."
  echo "   If the relay lives elsewhere, set its path here and re-run:"
  echo "     RELAY=/path/to/optimus-relay  bash \"$0\""
  [ -n "${RELAY:-}" ] || { read -p "Press Enter to close"; exit 1; }
fi
echo "relay: $RELAY"

# 2. back up + replace the catalog page with the self-syncing one
ts=$(date +%Y%m%d-%H%M%S)
cp "$RELAY/public/ops/drivers.html" "$RELAY/public/ops/drivers.html.bak.$ts" 2>/dev/null \
  && echo "  backed up old page -> drivers.html.bak.$ts"
if curl -fsS "$CH/ops/drivers.html" -o "$RELAY/public/ops/drivers.html"; then
  echo "  ✓ catalog page updated (now reads the live channel automatically)"
else
  echo "  !! could not download the new page from the channel"; read -p "Press Enter"; exit 1
fi

# 3. refresh the relay's local driver store from the channel (best-effort)
SLUGS=$(curl -fsS "$CH/index.json" 2>/dev/null | tr -d '[]"[:space:]' | tr ',' ' ')
for slug in $SLUGS; do
  mkdir -p "$RELAY/public/drivers/$slug"
  curl -fsS "$CH/$slug/version.json" -o "$RELAY/public/drivers/$slug/version.json" 2>/dev/null
  curl -fsS "$CH/$slug/$slug.c4z"   -o "$RELAY/public/drivers/$slug/$slug.c4z"   2>/dev/null \
    && echo "  ✓ synced store: $slug"
done

echo "--------------------------------------------------------------"
echo " Done. Open relay.integrateit.dev/ops/drivers.html (hard-refresh:"
echo " Cmd-Shift-R). It will now always show the current published versions."
echo "--------------------------------------------------------------"
read -p "Press Enter to close"
