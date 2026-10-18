#!/bin/bash

# 1. Tắt Google Play Protect và chỉnh DPI màn hình
su -c "settings put global package_verifier_enable 0"
su -c "settings put global upload_apk_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"
su -c "pkill com.android.systemui"

echo "========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "========================================="

# 2. Xoá thư mục cũ và tạo thư mục lưu trữ mới
rm -rf /sdcard/Download/DeltaClones
mkdir -p /sdcard/Download/DeltaClones

# 3. Danh sách link gốc chính xác của bạn
LINKS=(
"https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT_No_SameHwi.By.Anya.01-2.741.1062.apk_clone.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT_No_SameHwi.By.Anya.02-2.741.1062.apk_clone.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT_No_SameHwi.By.Anya.03-2.741.1062.apk_clone.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT_No_SameHwi.By.Anya.04-2.741.1062.apk_clone.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/WARP.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/termux-boot-app_v0.8.1%2Bgithub.debug.1.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/ru-zdevs-zarchiver-pro-9595-57938212-9383d33dd7cc90d9d.apk"
"https://github.com/NKDangK0/tools/releases/download/v1.1/MT-Manager_2.14.5_v8a.apk"
)

# 4. Tên file lưu tương ứng giữ nguyên tên chuẩn để không bao giờ lệch
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

# 5. Vòng lặp tải và cài đặt
for i in "${!LINKS[@]}"; do
  url="${LINKS[$i]}"
  name="${NAMES[$i]}"
  sd_path="/sdcard/Download/DeltaClones/$name"

  echo "-----------------------------------------"
  echo "[+] Đang tải ứng dụng $((i+1))..."
  curl -L --connect-timeout 30 -o "$sd_path" "$url"

  if [ -f "$sd_path" ] && [ -s "$sd_path" ]; then
    echo "[+] Đang cài đặt..."
    if su -c "pm install -r -d -g '$sd_path'" || su -c "cmd package install -r -d -g '$sd_path'"; then
      echo "[✓] Đã cài thành công ứng dụng $((i+1))"
    else
      echo "[!] Lỗi khi cài ứng dụng $((i+1))"
    fi
  else
    echo "[!] Lỗi: Không tải được file (Kiểm tra lại đường dẫn Release)"
  fi
done

rm -rf /sdcard/Download/DeltaClones

echo "========================================="
echo "   Đã hoàn tất quy trình cài đặt ứng dụng"
echo "========================================="
