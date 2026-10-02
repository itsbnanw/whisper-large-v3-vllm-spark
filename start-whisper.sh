#!/usr/bin/env bash
set -euo pipefail

echo "Starting ${MODEL_ID}"
echo "GPU memory utilization: ${GPU_MEMORY_UTILIZATION}"
echo "Max concurrent sequences: ${MAX_NUM_SEQS}"
echo "Listening on 0.0.0.0:${PORT}"

exec vllm serve "${MODEL_ID}" \
  --host 0.0.0.0 \
  --port "${PORT}" \
  --gpu-memory-utilization "${GPU_MEMORY_UTILIZATION}" \
  --max-num-seqs "${MAX_NUM_SEQS}" \
  "$@"
