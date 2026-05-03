import runpod
import torch
from diffusers import FluxPipeline
import base64
from io import BytesIO

# Загрузка модели
def load_model():
    pipe = FluxPipeline.from_pretrained(
        "black-forest-labs/FLUX.1-schnell", 
        torch_dtype=torch.bfloat16
    ).to("cuda")
    return pipe

pipe = load_model()

def handler(job):
    job_input = job["input"]
    prompt = job_input.get("prompt", "A futuristic cyberpunk city")
    
    # Генерация
    image = pipe(
        prompt, 
        guidance_scale=0.0, 
        num_inference_steps=4, 
        max_sequence_length=256
    ).images[0]
    
    # Конвертация в Base64
    buffered = BytesIO()
    image.save(buffered, format="PNG")
    img_str = base64.b64encode(buffered.getvalue()).decode()
    
    return {"image": img_str}

runpod.serverless.start({"handler": handler})
