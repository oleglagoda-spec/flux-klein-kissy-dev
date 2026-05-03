# Используем образ с PyTorch 2.4.0, который нужен новому ComfyUI
# Используем проверенную базу, которая точно собирается в RunPod
FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Устанавливаем aria2 и системные зависимости
RUN apt-get update && apt-get install -y git wget curl python3-pip aria2

# Обновляем pip и ставим Jupyter Lab
RUN pip install --upgrade pip && pip install --no-cache-dir jupyterlab

# Клонируем ComfyUI и устанавливаем зависимости (фиксируем версии для стабильности)
RUN git clone https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install --no-cache-dir -r requirements.txt

# Устанавливаем ComfyUI-Manager
RUN mkdir -p /workspace/custom_nodes && \
    cd /workspace/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Копируем скрипт запуска
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открываем порты для доступа
EXPOSE 8181 8888

ENTRYPOINT ["/entrypoint.sh"]
