FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv \
    ffmpeg git openssh-server \
    libsndfile1-dev build-essential \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install PyTorch with CUDA 12.1 FIRST (this is important)
RUN python3 -m pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Now install clearvoice + streamlit
RUN python3 -m pip install --no-cache-dir clearvoice streamlit

WORKDIR /app
CMD ["sleep", "infinity"]
