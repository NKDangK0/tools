#!/bin/bash

# 1. Tắt Google Play Protect và chỉnh DPI màn hình
su -c "settings put global package_verifier_enable 0"
su -c "settings put global upload_apk_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"
su -c "pkill com.android.systemui"

# Thông báo bắt đầu
echo "========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "========================================="

# 2. Xoá thư mục cũ và tạo thư mục lưu trữ mới
rm -rf /sdcard/Download/DeltaClones
mkdir -p /sdcard/Download/DeltaClones

# 3. Danh sách link các ứng dụng với tên file ngắn gọn, sạch sẽ
LINKS=(
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta1.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta2.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta3.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/delta4.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/warp.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/termuxboot.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/zarchiver.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/mtmanager.apk"
)

NAMES=(
"delta1.apk"
"delta2.apk"
"delta3.apk"
"delta4.apk"
"warp.apk"
"termuxboot.apk"
"zarchiver.apk"
"mtmanager.apk"
)

# 4. Vòng lặp tải và ép cài ngầm
for i in "${!LINKS[@]}"; do
  url="${LINKS[$i]}"
  name="${NAMES[$i]}"
  sd_path="/sdcard/Download/DeltaClones/$name"

  echo "-----------------------------------------"
  echo "[+] Đang tải $name..."
  curl -L --connect-timeout 20 -o "$sd_path" "$url"

  if [ -f "$sd_path" ] && [ -s "$sd_path" ]; then
    echo "[+] Đang tự động cài $name..."
    if su -c "pm install -r -d -g '$sd_path'" || su -c "cmd package install -r -d -g '$sd_path'"; then
      echo "[✓] Đã cài thành công: $name"
    else
      echo "[!] Lỗi cài đặt: $name"
    fi
  else
    echo "[!] Lỗi: Không tải được file $name"
  fi
done

# Dọn dẹp
rm -rf /sdcard/Download/DeltaClones

# Thông báo hoàn tất
echo "========================================="
echo "   Đã hoàn thành cài đặt những ứng dụng  "
echo "========================================="
