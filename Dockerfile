FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /workspace

# Установка системных зависимостей и Jupyter
RUN apt-get update && apt-get install -y git wget curl python3-pip
RUN pip install jupyterlab

# Клонируем ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN pip install -r requirements.txt

# Скрипт автоматической загрузки твоих моделей
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открываем порты: 8181 для ComfyUI, 8888 для Jupyter
EXPOSE 8181 8888

ENTRYPOINT ["/entrypoint.sh"]
