
FROM python:3.10-slim-bullseye
#FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-runtime

#ENV XDG_CACHE_HOME=/var/cache
#ENV PIP_CACHE_DIR=/var/cache/pip
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

#libtcmalloc-minimal4t64
RUN --mount=target=/var/lib/apt/lists,type=cache \
    --mount=target=/var/cache/apt,type=cache \
    apt update \
    && apt install -y git libglib2.0-0 libgl1-mesa-glx sudo

RUN install -v -m 0777 -o nobody -g nogroup -d /app \
    && usermod --groups sudo --home /app nobody

RUN chpasswd <<<"whatever"

USER nobody:nogroup
WORKDIR /app

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /app \
 && mkdir /app/.cache

# RUN mkdir stable-diffusion-webui
# COPY . stable-diffusion-webui/
# COPY webui.sh webui-user.sh ./
# COPY . .

# EXPOSE 7860/tcp

CMD ["/app/webui.sh","--api","--listen"]
# CMD ["python","-u","launch.py","--api"]

# docker run --gpus all -p 7860:7860 --tty --interactive --name a1 gchr.io/gsfjohnson/automatic1111-docker:main
