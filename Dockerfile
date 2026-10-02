ARG VLLM_VERSION=0.30.0
FROM vllm/vllm-openai:v${VLLM_VERSION}

ARG VLLM_VERSION

USER root

# Audio decoding support for Whisper.
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# vLLM's official image intentionally omits optional audio dependencies.
# Keep this version exactly aligned with the base vLLM image.
RUN uv pip install --system "vllm[audio]==${VLLM_VERSION}"

COPY start-whisper.sh /usr/local/bin/start-whisper
RUN chmod +x /usr/local/bin/start-whisper

ENV MODEL_ID=openai/whisper-large-v3 \
    GPU_MEMORY_UTILIZATION=0.04 \
    MAX_NUM_SEQS=1 \
    PORT=8000

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/start-whisper"]
