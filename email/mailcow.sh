#!/usr/bin/env bash
set -euo pipefail
if [ "$(id -u)" -ne 0 ]; then
  echo "error: this script must be run as root."
  exit 1
fi
apt update
apt install -y git openssl curl gawk coreutils grep jq
curl -sSL https://get.docker.com/ | CHANNEL=stable sh
systemctl enable --now docker
apt update
apt install docker-compose-plugin
umask 0022
cd /opt
git clone https://github.com/mailcow/mailcow-dockerized
cd mailcow-dockerized
./generate_config.sh
docker compose pull
docker compose up -d