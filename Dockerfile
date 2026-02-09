# Usa a imagem base limpa do RunPod
FROM runpod/worker-comfyui:5.5.1-base

# Configuração de shell para evitar erros ocultos
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 1. Cria as pastas necessárias
RUN mkdir -p /comfyui/models/diffusion_models
RUN mkdir -p /comfyui/models/text_encoders
RUN mkdir -p /comfyui/models/vae

# 2. Downloads de Modelos
# ATENÇÃO: Usando links 'resolve' (não blob) e fontes PÚBLICAS.

# Modelo Z Image Turbo (Público da Comfy-Org)
RUN wget -O /comfyui/models/diffusion_models/z_image_turbo_bf16.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors"

# Text Encoder Qwen (Público da Comfy-Org)
RUN wget -O /comfyui/models/text_encoders/qwen_3_4b.safetensors "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors"

# --- VAE CORRIGIDO (LINK PÚBLICO) ---
# Trocamos o link da Black Forest (bloqueado) pelo link do Kijai (público)
RUN wget -O /comfyui/models/vae/ae.safetensors "https://huggingface.co/Kijai/flux-fp8/resolve/main/ae.safetensors"

# Comando de inicialização padrão
CMD ["python", "-u", "/handler.py"]
