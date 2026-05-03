FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /

# Устанавливаем системные утилиты
RUN apt-get update && apt-get install -y git wget curl

# Устанавливаем библиотеки для ИИ и RunPod
RUN pip install runpod diffusers transformers accelerate safetensors requests

# Копируем наш будущий скрипт
COPY handler.py /handler.py

# Команда для запуска
CMD [ "python", "-u", "/handler.py" ]
