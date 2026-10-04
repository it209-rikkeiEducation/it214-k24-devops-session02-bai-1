#!/usr/bin/env bash

set -euo pipefail

KEY_PATH="$HOME/.ssh/id_ed25519_do"
KEY_COMMENT="devops-staging-key@digitalocean"

echo "=== 1. Kiêm tra và tạo thư mục ~/.ssh ==="
mkdir -p ~/.ssh
chmod 700 ~/.ssh

echo "=== 2. Khởi tạo SSH Keypair (Ed25519) ==="
if [ -f "$KEY_PATH" ]; then
    echo "[!] Khóa SSH $KEY_PATH đã tồn tại. Bỏ qua bước tạo khóa."
else
    ssh-keygen -t ed25519 -C "$KEY_COMMENT" -f "$KEY_PATH" -N ""
    echo "[+] Khóa SSH đã được tạo thành công tại: $KEY_PATH"
fi

echo "=== 3. Phân quyền tệp tin an toàn ==="
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo "=== 4. Nội dung Public Key để dán vào DigitalOcean ==="
echo "-------------------------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "-------------------------------------------------------------------"
echo "Hãy copy toàn bộ chuỗi trên và dán vào SSH Keys trong DigitalOcean Console."
