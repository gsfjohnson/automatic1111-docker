
FROM python:3.10-slim-bullseye
#FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-runtime

#ENV XDG_CACHE_HOME=/var/cache
#ENV PIP_CACHE_DIR=/var/cache/pip
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN --mount=target=/var/lib/apt/lists,type=cache \
    --mount=target=/var/cache/apt,type=cache \
 apt update \
 && apt install -y git libglib2.0-0 libgl1-mesa-glx sudo libtcmalloc-minimal4

RUN install -v -m 0777 -o nobody -g nogroup -d /app \
 && usermod --home /app nobody

COPY nobody /etc/sudoers.d/nobody

USER nobody:nogroup
WORKDIR /app

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /app \
 && git clone https://github.com/Stability-AI/stablediffusion.git /app/repositories/stable-diffusion-stability-ai \
 && git clone https://github.com/crowsonkb/k-diffusion.git /app/repositories/k-diffusion \
 && git clone https://github.com/salesforce/BLIP.git /app/repositories/BLIP \
 && mkdir /app/.cache

# RUN mkdir stable-diffusion-webui
# COPY . stable-diffusion-webui/
# COPY webui.sh webui-user.sh ./
# COPY . .

# EXPOSE 7860/tcp

CMD ["/app/webui.sh","--api","--listen","--xformers"]
# CMD ["python","-u","launch.py","--api","--xformers"]

# docker run --gpus all -p 7860:7860 --tty --interactive --name a1 gchr.io/gsfjohnson/automatic1111-docker:main
