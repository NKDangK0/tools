document.addEventListener("DOMContentLoaded", () => {
    const button = document.getElementById("btn");
    const urlInput = document.getElementById("urlInput");
    const resultBox = document.getElementById("resultBox");
    const message = document.getElementById("msg");
    const targetLink = document.getElementById("targetLink");

    button.addEventListener("click", async () => {
        const inputUrl = urlInput.value.trim();

        if (!inputUrl) {
            alert("Vui lòng dán đường link cần vượt vào ô, boss man!");
            return;
        }

        resultBox.classList.remove("hidden");
        targetLink.classList.add("hidden");
        message.textContent = "🤖 AI đang tự động vượt link, vui lòng chờ giây lát...";

        try {
            // Gửi link cho AI/API tự động giải mã ngầm
            const apiUrl = `https://ethon-bypass-api.vercel.app/api/bypass?url=${encodeURIComponent(inputUrl)}`;
            const response = await fetch(apiUrl);
            const data = await response.json();

            let finalUrl = data.result || data.bypassed_url || data.url;

            // Kiểm tra nếu AI vượt thành công và trả về đúng link web
            if (finalUrl && (finalUrl.startsWith("http://") || finalUrl.startsWith("https://"))) {
                message.textContent = "🎉 AI đã vượt link thành công!";
                targetLink.href = finalUrl;
                targetLink.textContent = "🚀 Bấm vào đây để tới thẳng trang web gốc";
                targetLink.classList.remove("hidden");
            } else {
                message.textContent = "❌ AI không thể vượt được link này hoặc link không hỗ trợ.";
            }
        } catch (error) {
            message.textContent = "⚠️ Lỗi kết nối tới AI vượt link. Vui lòng thử lại sau!";
        }
    });
});
