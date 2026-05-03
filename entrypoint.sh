#!/bin/bash

# Создаем структуру папок
mkdir -p /workspace/models/checkpoints /workspace/models/vae /workspace/models/clip /workspace/models/loras

# Скачиваем модели (используем aria2 для скорости)
echo "--- Загрузка Klein 9B ---"
aria2c -x 16 -s 16 -o /workspace/models/checkpoints/flux-2-klein-9b.safetensors "https://huggingface.co/black-forest-labs/FLUX.2-klein-9B/resolve/main/flux-2-klein-9b.safetensors?download=true"

echo "--- Загрузка VAE ---"
aria2c -x 16 -s 16 -o /workspace/models/vae/flux2-vae.safetensors "https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors?download=true"

echo "--- Загрузка Qwen Encoder ---"
aria2c -x 16 -s 16 -o /workspace/models/clip/qwen_3_8b_fp8mixed.safetensors "https://huggingface.co/Comfy-Org/vae-text-encorder-for-flux-klein-9b/resolve/main/split_files/text_encoders/qwen_3_8b_fp8mixed.safetensors?download=true"

# Запуск Jupyter Lab в фоне на порту 8888
jupyter lab --allow-root --ip=0.0.0.0 --no-browser --NotebookApp.token='' --NotebookApp.password='' &

# Запуск ComfyUI на порту 8181
python3 main.py --listen 0.0.0.0 --port 8181
