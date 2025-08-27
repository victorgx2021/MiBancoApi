#!/bin/bash
set -e

if [[ -z "$GH_URL" || -z "$GH_TOKEN" ]]; then
  echo "❌ GH_URL y GH_TOKEN deben estar definidos"
  exit 1
fi

./config.sh --unattended \
  --url "$GH_URL" \
  --token "$GH_TOKEN" \
  --name "${RUNNER_NAME:-self-hosted-$(hostname)}" \
  --work "${RUNNER_WORKDIR:-_work}" \
  --labels "${RUNNER_LABELS:-default_runner}" \
  --replace

exec ./run.sh
