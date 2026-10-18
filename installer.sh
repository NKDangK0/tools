#!/bin/bash

su -c "settings put global package_verifier_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"

echo "=== TEST CAI 2 APP ==="

rm -rf /sdcard/Download/DeltaClones
mkdir -p /sdcard/Download/DeltaClones

LINKS=(
"https://github.com/NKDangK0/tools/releases/download/v1.1/ru-zdevs-zarchiver-pro-9595-57938212-9383d33dd7cc90d9d.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/MT-Manager_2.14.5_v8a.apk"
)

NAMES=(
"zarchiver.apk"
"mtmanager.apk"
)

for i in "${!LINKS[@]}"; do
  url="${LINKS[$i]}"
  name="${NAMES[$i]}"
  sd_path="/sdcard/Download/DeltaClones/$name"

  echo "-----------------------------------------"
  echo "[+] Đang tải $name..."
  curl -L --connect-timeout 30 -o "$sd_path" "$url"

  if [ -f "$sd_path" ] && [ -s "$sd_path" ]; then
    echo "[+] Đang cài đặt $name..."
    su -c "pm install -r -d -g '$sd_path'" && echo "[✓] Xong $name" || echo "[!] Lỗi lệnh pm install $name"
  else
    echo "[!] Không tải được $name"
  fi
done

rm -rf /sdcard/Download/DeltaClones
echo "=== HOAN TAT ==="
