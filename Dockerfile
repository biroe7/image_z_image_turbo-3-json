# Usa a imagem base limpa do RunPod
FROM runpod/worker-comfyui:5.5.1-base

# Configuração de shell para evitar erros
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 1. Cria as pastas necessárias
RUN mkdir -p /comfyui/models/diffusion_models
RUN mkdir -p /comfyui/models/text_encoders
RUN mkdir -p /comfyui/models/vae

# 2. Downloads de Modelos
# ATENÇÃO: Links públicos verificados.

# Modelo Z Image Turbo (Público)
RUN wget -O /comfyui/models/diffusion_models/z_image_turbo_bf16.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors"

# Text Encoder Qwen (Público)
RUN wget -O /comfyui/models/text_encoders/qwen_3_4b.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors"

# --- VAE CORRIGIDO (LINK DO CAMENDURU) ---
# Este link é 100% público e contém o arquivo ae.safetensors correto
RUN wget -O /comfyui/models/vae/ae.safetensors "https://huggingface.co/camenduru/FLUX.1-dev/resolve/main/ae.safetensors"

# Comando de inicialização padrão
CMD ["python", "-u", "/handler.py"]
