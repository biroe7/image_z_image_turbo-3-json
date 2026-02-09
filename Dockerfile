# Usa a imagem base limpa do RunPod
FROM runpod/worker-comfyui:5.5.1-base

# Cria as pastas necessárias para garantir que não dê erro de "diretório não encontrado"
RUN mkdir -p /comfyui/models/diffusion_models
RUN mkdir -p /comfyui/models/text_encoders
RUN mkdir -p /comfyui/models/vae

# --- DOWNLOAD DOS MODELOS (CORRIGIDOS) ---
# Usamos 'wget' e links 'resolve' para garantir que baixamos o arquivo real, não o site HTML.

# 1. Diffusion Model (Corrigido de blob -> resolve)
RUN wget -O /comfyui/models/diffusion_models/z_image_turbo_bf16.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors"

# 2. Text Encoder (Corrigido de blob -> resolve)
RUN wget -O /comfyui/models/text_encoders/qwen_3_4b.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors"

# 3. VAE (Flux Schnell)
RUN wget -O /comfyui/models/vae/ae.safetensors "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors"

# A imagem base já cuida da inicialização, não precisa de CMD extra.
