
# FROM python:3.11-slim-bullseye
FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-runtime

ENV TZ=Etc/UTC

RUN --mount=target=/var/lib/apt/lists,type=cache \
    --mount=target=/var/cache/apt,type=cache \
    apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y git libglib2.0-0 libgl1-mesa-glx
    && mkdir -p /app

WORKDIR /app

# RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
# RUN mkdir stable-diffusion-webui
# COPY . stable-diffusion-webui/
# COPY webui.sh webui-user.sh ./
COPY . .

# EXPOSE 7860/tcp

# CMD /app/webui.sh --api
CMD /opt/conda/bin/python3 -u launch.py --api
