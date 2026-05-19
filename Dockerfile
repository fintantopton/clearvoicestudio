# Base: CUDA 12.1 Ubuntu 22.04 (matches your torch index-url)
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Set non-interactive & Python env
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies (critical for clearvoice/whisper audio)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-dev \
    build-essential libsndfile1-dev ffmpeg git \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Upgrade pip, setuptools, wheel (fix resolver issues)
RUN python3 -m pip install --upgrade pip setuptools wheel

# Step 1: Install PyTorch CUDA 12.1 FIRST (force GPU wheels)
RUN python3 -m pip install --no-cache-dir \
    torch==2.3.0 torchvision==0.18.0 torchaudio==2.3.0 \
    --index-url https://download.pytorch.org/whl/cu121

# Step 2: Install clearvoice + streamlit (separate, no torch conflict)
RUN python3 -m pip install --no-cache-dir clearvoice streamlit

WORKDIR /app
# Optional: Add your Streamlit app entrypoint
# COPY app.py .
# CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
CMD ["sleep", "infinity"]
