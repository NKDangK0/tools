#!/bin/bash

# ====================================================
# 1. TẮT PLAY PROTECT & CHỈNH DPI MÀN HÌNH
# ====================================================
su -c "settings put global package_verifier_enable 0"
su -c "settings put global upload_apk_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"
su -c "pkill com.android.systemui"

echo "========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "========================================="

# 2. Tạo thư mục lưu tạm
DIR="/sdcard/Download/DeltaClones"
rm -rf "$DIR"
mkdir -p "$DIR"

# 3. Danh sách 7 ứng dụng chuẩn của bạn
LINKS=(
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta1.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta2.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta3.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta4.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/mtmanager.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/zarchiver.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/warp.apk"
)

NAMES=(
"delta1.apk"
"delta2.apk"
"delta3.apk"
"delta4.apk"
"mtmanager.apk"
"zarchiver.apk"
"warp.apk"
)

# 4. Vòng lặp tải và cài đặt ngầm
for i in "${!LINKS[@]}"; do
  url="${LINKS[$i]}"
  name="${NAMES[$i]}"
  path="$DIR/$name"

  echo "-----------------------------------------"
  echo "[+] Đang tải $name..."
  curl -L --connect-timeout 30 -o "$path" "$url"

  if [ -f "$path" ] && [ -s "$path" ]; then
    echo "[+] Đang cài đặt $name..."
    if su -c "pm install -r -d -g '$path'" || su -c "cmd package install -r -d -g '$path'"; then
      echo "[✓] Đã cài thành công: $name"
    else
      echo "[!] Lỗi hệ thống khi cài $name"
    fi
  else
    echo "[!] Lỗi: Không tải được $name"
  fi
done

# Dọn dẹp
rm -rf "$DIR"

echo "========================================="
echo "   Đã hoàn tất quy trình cài đặt ứng dụng"
echo "========================================="
