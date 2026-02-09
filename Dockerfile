# Usa a imagem base limpa do RunPod
FROM runpod/worker-comfyui:5.7.1-base

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# --- CORREÇÃO DO ERRO ---
# Instala as dependências que o modelo Qwen/Z-Image exige para não travar
RUN pip install sentencepiece protobuf

# Cria as pastas corretas
RUN mkdir -p /comfyui/models/unet
RUN mkdir -p /comfyui/models/clip
RUN mkdir -p /comfyui/models/vae

# Downloads (Com os caminhos corrigidos)

# 1. UNET (Z-Image)
RUN wget -O /comfyui/models/unet/z_image_turbo_bf16.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors"

# 2. CLIP (Qwen) - Esse é o arquivo que precisava do sentencepiece
RUN wget -O /comfyui/models/clip/qwen_3_4b.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors"

# 3. VAE (Flux/Standard)
RUN wget -O /comfyui/models/vae/ae.safetensors "https://huggingface.co/camenduru/FLUX.1-dev/resolve/main/ae.safetensors"

# Removemos o CMD manual. Deixamos o container usar o script de inicialização inteligente padrão.
