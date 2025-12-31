#!/bin/bash
set -e

echo ">> Desativando unattended-upgrades"
systemctl stop unattended-upgrades || true
systemctl disable unattended-upgrades || true

echo ">> Removendo snap"
systemctl stop snapd.service snapd.socket || true
systemctl disable snapd.service snapd.socket || true
systemctl mask snapd.service snapd.socket || true
apt purge snapd -y || true
rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd

echo ">> Saneando sistema"
apt update
apt full-upgrade -y
apt autoremove --purge -y
journalctl --vacuum-time=14d
systemctl daemon-reexec

echo ">> Baseline aplicado com sucesso"
