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
        message.textContent = "⏳ Đang giải mã và vượt link, vui lòng đợi...";

        try {
            // Sử dụng API bypass công khai
            const apiUrl = `https://api.bypass.vip/bypass?url=${encodeURIComponent(inputUrl)}`;
            const response = await fetch(apiUrl);
            const data = await response.json();

            if (data && data.result) {
                message.textContent = "✅ Vượt link thành công!";
                targetLink.href = data.result;
                targetLink.textContent = "👉 Bấm vào đây để tới link đích";
                targetLink.classList.remove("hidden");
            } else {
                message.textContent = "❌ Không thể giải mã link này hoặc link không được hỗ trợ.";
            }
        } catch (error) {
            message.textContent = "⚠️ Lỗi kết nối tới Server API bypass. Vui lòng thử lại sau!";
        }
    });
});
