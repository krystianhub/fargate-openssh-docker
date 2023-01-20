FROM ghcr.io/linuxserver/openssh-server:9.0_p1-r2-ls100

ENV SUDO_ACCESS=true
ENV PASSWORD_ACCESS=true

COPY ./config/aws_env.sh /etc/cont-init.d/05-aws-env
COPY ./config/rclone.conf /config/.config/rclone/rclone.conf

RUN apk add --no-cache htop rclone
