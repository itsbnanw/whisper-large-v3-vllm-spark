# Whisper Large-v3 on DGX Spark with vLLM

Pinned to vLLM 0.30.0 and configured for a single-user Whisper service.

## Build

```bash
docker build --pull -t whisper-large-v3-vllm:0.30.0 .
```

## Run

```bash
docker run -d \
  --name whisper-large-v3 \
  --gpus all \
  --ipc=host \
  --restart unless-stopped \
  -p 8001:8000 \
  -v "$HOME/.cache/huggingface:/root/.cache/huggingface" \
  -e GPU_MEMORY_UTILIZATION=0.04 \
  -e MAX_NUM_SEQS=1 \
  whisper-large-v3-vllm:0.30.0
```

Or:

```bash
docker compose up -d --build
```

## Test

```bash
curl -sS http://localhost:8001/v1/audio/transcriptions \
  -F "file=@audio.m4a" \
  -F "model=openai/whisper-large-v3"
```

## Logs

```bash
docker logs -f whisper-large-v3
```

## Stop / start

```bash
docker stop whisper-large-v3
docker start whisper-large-v3
```

## Memory tuning

The default is `GPU_MEMORY_UTILIZATION=0.04`.

If startup reports insufficient memory/cache, try:

```bash
-e GPU_MEMORY_UTILIZATION=0.05
```

If 0.04 is stable and you want to test tighter allocation:

```bash
-e GPU_MEMORY_UTILIZATION=0.035
```

`MAX_NUM_SEQS=1` is intentional for a single-user deployment.
