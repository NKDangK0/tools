#!/usr/bin/env bash

# Cấu hình cài đặt hệ thống bằng Root
su -c "settings put system user_rotation 0"
su -c "wm density 180"
su -c "settings put global package_verifier_enable 0"

echo "=========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "=========================================="

LINKS=(
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.01-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.04-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.03-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.02-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/com-cloudflare-onedotonedotonedotone-3837-66752135-ef8"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/MT+Manager_2.26.8_APKPure.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/termux-boot-app_v0.8.1+github.debug.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/ZArchiver_1.0.10_APKPure.apk"
)

DEST_DIR="/data/local/tmp/installer_apks"
su -c "mkdir -p '$DEST_DIR' && chmod 777 '$DEST_DIR'"

for url in "${LINKS[@]}"; do
  filename=$(basename "$url")
  
  # Đảm bảo tên file lưu lại luôn kết thúc bằng .apk
  if [[ "$filename" != *.apk ]]; then
    target_name="${filename}.apk"
  else
    target_name="$filename"
  fi
  
  filepath="$DEST_DIR/$target_name"

  echo "--> Đang tải: $filename..."
  su -c "curl -L -s -o '$filepath' '$url'"

  if [ -f "$filepath" ]; then
    echo "--> Đang cài đặt: $target_name..."
    su -c "chmod 666 '$filepath'"
    # Thêm tham số -r -d -g để ép cài đặt đè, hạ cấp và tự cấp quyền
    su -c "pm install -r -d -g '$filepath'"
    su -c "rm -f '$filepath'"
  else
    echo "[!] Lỗi: Không thể tải $filename"
  fi
done

su -c "rm -rf '$DEST_DIR'"

echo "=========================================="
echo "    Đã hoàn thành cài đặt những ứng dụng  "
echo "=========================================="
