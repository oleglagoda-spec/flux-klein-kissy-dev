FROM runpod/pytorch:2.2.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /

RUN apt-get update && apt-get install -y git wget curl

RUN pip install --no-cache-dir \
    runpod==1.9.0 \
    diffusers==0.30.3 \
    transformers==4.44.2 \
    accelerate==0.34.0 \
    safetensors \
    requests

ENV ACCELERATE_USE_XPU=False

COPY handler.py /handler.py

CMD [ "python", "-u", "/handler.py" ]
