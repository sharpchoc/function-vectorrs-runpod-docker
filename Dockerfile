FROM nvidia/cuda:13.0.2-cudnn-devel-ubuntu22.04

SHELL ["/bin/bash", "-lc"]

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip \
    git \
    tmux \
    vim \
    htop \
    curl \
    wget \
    build-essential \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN python3.10 -m pip install --upgrade pip setuptools wheel

COPY requirements.txt /tmp/requirements.txt

RUN python3.10 -m pip install -r /tmp/requirements.txt

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV HF_HOME=/workspace/model_cache/huggingface
ENV TRANSFORMERS_CACHE=/workspace/model_cache/huggingface
ENV HF_DATASETS_CACHE=/workspace/model_cache/huggingface/datasets
ENV WANDB_DIR=/workspace/wandb
ENV PIP_CACHE_DIR=/workspace/model_cache/pip
ENV HF_HUB_ENABLE_HF_TRANSFER=1

CMD ["/start.sh"]
