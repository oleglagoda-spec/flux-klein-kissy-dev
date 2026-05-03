FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Установка aria2 и системных утилит
RUN apt-get update && apt-get install -y git wget curl python3-pip aria2

# Установка Jupyter Lab
RUN pip install --no-cache-dir jupyterlab

# Клонирование ComfyUI и установка зависимостей
RUN git clone https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install --no-cache-dir -r requirements.txt

# Установка ComfyUI-Manager
RUN mkdir -p /workspace/custom_nodes && \
    cd /workspace/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Копируем скрипт запуска
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открываем порты доступа
EXPOSE 8181 8888

ENTRYPOINT ["/entrypoint.sh"]
