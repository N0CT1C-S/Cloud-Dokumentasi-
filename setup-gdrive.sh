#!/bin/bash

# ====================================================================
# Script Automation Mount GDrive & Maintenance Server fufufafa
# ====================================================================

MOUNT_PATH="/mnt/gdrive"
REMOTE_NAME="drive:" # Sesuaikan dengan nama remote rclone 

echo "======================================================"
echo "[+] Memulai Pembersihan Cache dan Log Sampah Sistem..."
echo "======================================================"

# 1. Bersihkan sisa log systemd yang numpuk (Sisakan log 2 hari terakhir)
sudo journalctl --vacuum-time=2d

# 2. Bersihkan cache apt & cache jellyfin lawas
sudo apt-get clean -y
sudo rm -rf /var/cache/jellyfin/*
rm -rf ~/.cache/rclone/*

echo "[+] Selesai pembersihan sampah lokal."
echo ""
echo "======================================================"
echo "[+] Memulai Proses Mounting Google Drive via Rclone..."
echo "======================================================"

# 3. Unmount jalur lama jika nge-hang
sudo fusermount -u $MOUNT_PATH 2>/dev/null
sudo killall rclone 2>/dev/null
sleep 2

# 4. Membuat folder mount jika belum ada
mkdir -p $MOUNT_PATH

# 5. Jalankan rclone mount di background dengan optimasi VFS streaming
rclone mount $REMOTE_NAME $MOUNT_PATH \
  --allow-other \
  --dir-cache-time 5m \
  --vfs-cache-mode full \
  --vfs-read-chunk-size 32M \
  --vfs-read-chunk-size-limit 2G \
  --buffer-size 64M &

sleep 5

# 6. Verifikasi status mounting
if df -h | grep -q "$MOUNT_PATH"; then
    echo "[SUCCESS] Google Drive Berhasil Ditempel ke $MOUNT_PATH!"
    df -h $MOUNT_PATH
    
    echo ""
    echo "[+] Me-restart Service Jellyfin agar sinkron..."
    sudo systemctl restart jellyfin
    echo "[SUCCESS] Jellyfin Media Server Siap Digunakan!"
else
    echo "[ERROR] Gagal menempelkan Google Drive. Periksa kembali konfigurasi rclone lu!"
fi
echo "======================================================"

