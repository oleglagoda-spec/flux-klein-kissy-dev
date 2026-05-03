#!/bin/bash

# Токен Hugging Face
MY_TOKEN="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"

# Создаем структуру папок ComfyUI
mkdir -p /workspace/models/checkpoints /workspace/models/vae /workspace/models/clip /workspace/models/loras

# Скачивание Klein 9B
echo "--- Загрузка Klein 9B (~18 ГБ) ---"
aria2c -x 16 -s 16 --header="Authorization: Bearer $MY_TOKEN" -o /workspace/models/checkpoints/flux-2-klein-9b.safetensors "https://huggingface.co/black-forest-labs/FLUX.2-klein-9B/resolve/main/flux-2-klein-9b.safetensors?download=true" [cite: 270, 271]

# Скачивание VAE
echo "--- Загрузка VAE ---"
aria2c -x 16 -s 16 --header="Authorization: Bearer $MY_TOKEN" -o /workspace/models/vae/flux2-vae.safetensors "https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors?download=true" [cite: 278, 279]

# Скачивание Qwen Encoder
echo "--- Загрузка Qwen Encoder ---"
aria2c -x 16 -s 16 --header="Authorization: Bearer $MY_TOKEN" -o /workspace/models/clip/qwen_3_8b_fp8mixed.safetensors "https://huggingface.co/Comfy-Org/vae-text-encorder-for-flux-klein-9b/resolve/main/split_files/text_encoders/qwen_3_8b_fp8mixed.safetensors?download=true" [cite: 286, 287, 292]

# Запуск Jupyter Lab в фоне
jupyter lab --allow-root --ip=0.0.0.0 --no-browser --NotebookApp.token='' --NotebookApp.password='' & [cite: 300, 320]

# Запуск ComfyUI
echo "--- Запускаю ComfyUI ---"
python3 main.py --listen 0.0.0.0 --port 8181 [cite: 293, 327]
