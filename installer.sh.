#!/bin/bash
echo "=== BẮT ĐẦU TỰ ĐỘNG TẢI & CÀI ĐẶT TOÀN BỘ APP ==="

# 1. Tắt Google Play Protect và chỉnh DPI màn hình chuẩn 600dp
echo "[+] Đang tắt Play Protect và chỉnh DPI màn hình 600dp..."
su -c "settings put global package_verifier_enable 0"
su -c "settings put global upload_apk_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"
su -c "pkill com.android.systemui"

# 2. Xoá thư mục cũ và tạo thư mục lưu trữ mới
rm -rf /sdcard/Download/DeltaClones
mkdir -p /sdcard/Download/DeltaClones

# 3. Danh sách link 8 app (Đã thay 4 link Delta mới)
LINKS=(
  "https://files.catbox.moe/2jbbar.apk"
  "https://files.catbox.moe/qhkri6.apk"
  "https://files.catbox.moe/v5q1jq.apk"
  "https://files.catbox.moe/l2b4ei.apk"
  "https://f-droid.org/repo/com.termux.boot_7.apk"
  "https://files.catbox.moe/c601zz.apk"
  "https://files.catbox.moe/lksppe.apk"
  "https://files.catbox.moe/8l6c1g.apk"
)

NAMES=(
  "Delta_1.apk"
  "Delta_2.apk"
  "Delta_3.apk"
  "Delta_4.apk"
  "Termux_Boot.apk"
  "Warp_1111.apk"
  "ZArchiver.apk"
  "MT_Manager.apk"
)

# 4. Vòng lặp tải và ép cài ngầm
for i in "${!LINKS[@]}"; do
    url="${LINKS[$i]}"
    name="${NAMES[$i]}"
    path="/sdcard/Download/DeltaClones/$name"
    
    echo "--------------------------------------------"
    echo "[+] Đang tải $name..."
    curl -L --connect-timeout 15 -o "$path" "$url"
    
    echo "[+] Đang tự động cài $name..."
    su -c "pm install -r -d -g -i com.android.shell '$path'" || su -c "cmd package install -r -d -g '$path'"
done

echo "=== ĐÃ HOÀN THÀNH CÀI ĐẶT TOÀN BỘ 8 ỨNG DỤNG & CHỈNH DPI 600DP! ==="
