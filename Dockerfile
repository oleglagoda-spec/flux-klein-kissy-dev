FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /

# Системные зависимости
RUN apt-get update && apt-get install -y git wget curl

# Установка библиотек с фиксом версий
RUN pip install --no-cache-dir \
    runpod \
    diffusers==0.30.3 \
    transformers==4.44.2 \
    accelerate==0.34.0 \
    safetensors \
    requests

# Принудительное отключение XPU для стабильности
ENV ACCELERATE_USE_XPU=False

COPY handler.py /handler.py

CMD [ "python", "-u", "/handler.py" ]
