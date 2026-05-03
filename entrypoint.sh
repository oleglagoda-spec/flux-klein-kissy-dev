#!/bin/bash

# 1. Создаем структуру папок, которую ожидает ComfyUI
mkdir -p /workspace/models/checkpoints /workspace/models/vae /workspace/models/clip /workspace/models/loras

# 2. Проверка токена (выведет текст в логи, если забыл ввести HF_TOKEN в RunPod)
if [ -z "$HF_TOKEN" ]; then
    echo "ВНИМАНИЕ: Переменная HF_TOKEN пустая. Загрузка Klein 9B может не сработать!"
fi

# 3. Скачивание основных моделей через быстрый загрузчик aria2c
# Мы добавляем --header="Authorization: Bearer $HF_TOKEN", чтобы Hugging Face узнал тебя
echo "--- Начинаю загрузку Klein 9B (~18 ГБ) ---"
aria2c -x 16 -s 16 --header="Authorization: Bearer $HF_TOKEN" -o /workspace/models/checkpoints/flux-2-klein-9b.safetensors "https://huggingface.co/black-forest-labs/FLUX.2-klein-9B/resolve/main/flux-2-klein-9b.safetensors?download=true"

echo "--- Загрузка VAE ---"
aria2c -x 16 -s 16 --header="Authorization: Bearer $HF_TOKEN" -o /workspace/models/vae/flux2-vae.safetensors "https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors?download=true"

echo "--- Загрузка Qwen Encoder ---"
aria2c -x 16 -s 16 --header="Authorization: Bearer $HF_TOKEN" -o /workspace/models/clip/qwen_3_8b_fp8mixed.safetensors "https://huggingface.co/Comfy-Org/vae-text-encorder-for-flux-klein-9b/resolve/main/split_files/text_encoders/qwen_3_8b_fp8mixed.safetensors?download=true"

# 4. Запуск Jupyter Lab в фоне на порту 8888
# --NotebookApp.token='' позволит войти без пароля через кнопку Connect в RunPod
jupyter lab --allow-root --ip=0.0.0.0 --no-browser --NotebookApp.token='' --NotebookApp.password='' &

# 5. Запуск основного интерфейса ComfyUI на порту 8181
echo "--- Запускаю ComfyUI ---"
python3 main.py --listen 0.0.0.0 --port 8181
