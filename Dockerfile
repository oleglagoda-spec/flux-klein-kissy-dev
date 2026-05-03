FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Установка aria2 для загрузки и системных утилит
RUN apt-get update && apt-get install -y git wget curl python3-pip aria2 [cite: 101, 102]

# Установка Jupyter Lab
RUN pip install --no-cache-dir jupyterlab [cite: 103, 110]

# Клонирование ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install --no-cache-dir -r requirements.txt [cite: 293]

# Установка Менеджера узлов (ComfyUI-Manager)
RUN mkdir -p /workspace/custom_nodes && \
    cd /workspace/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git [cite: 322]

# Копируем скрипт запуска
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открываем порты доступа
EXPOSE 8181 8888

ENTRYPOINT ["/entrypoint.sh"]
