# Используем образ с PyTorch 2.4.0, который нужен новому ComfyUI
FROM runpod/pytorch:2.4.0-py3.10-cuda12.4.1-devel-ubuntu22.04

WORKDIR /workspace

# Устанавливаем aria2 явно
RUN apt-get update && apt-get install -y git wget curl python3-pip aria2

# Устанавливаем Jupyter Lab
RUN pip install --no-cache-dir jupyterlab

# Клонируем ComfyUI и ставим зависимости
RUN git clone https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install --no-cache-dir -r requirements.txt

# Устанавливаем менеджер узлов
RUN mkdir -p /workspace/custom_nodes && \
    cd /workspace/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8181 8888

ENTRYPOINT ["/entrypoint.sh"]
