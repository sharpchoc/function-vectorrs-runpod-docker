#!/usr/bin/env bash
set -e

mkdir -p /workspace/repos
mkdir -p /workspace/model_cache/huggingface
mkdir -p /workspace/model_cache/pip
mkdir -p /workspace/datasets
mkdir -p /workspace/activations
mkdir -p /workspace/function_vectors
mkdir -p /workspace/probe_results
mkdir -p /workspace/checkpoints
mkdir -p /workspace/wandb

cd /workspace

python3.10 -m jupyter lab \
  --ip=0.0.0.0 \
  --port=8888 \
  --allow-root \
  --no-browser \
  --NotebookApp.token='' \
  --NotebookApp.password=''
