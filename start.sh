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

# Set up SSH
mkdir -p /var/run/sshd
mkdir -p /root/.ssh
chmod 700 /root/.ssh

if [ -n "${PUBLIC_KEY:-}" ]; then
  echo "$PUBLIC_KEY" > /root/.ssh/authorized_keys
  chmod 600 /root/.ssh/authorized_keys
fi

# Allow root login with SSH key
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config || true
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config || true
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config || true

/usr/sbin/sshd

cd /workspace

python -m jupyter lab \
  --ip=0.0.0.0 \
  --port=8888 \
  --allow-root \
  --no-browser \
  --NotebookApp.token='' \
  --NotebookApp.password=''
