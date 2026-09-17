document.addEventListener("DOMContentLoaded", () => {
    const button = document.getElementById("btn");
    const urlInput = document.getElementById("urlInput");
    const resultBox = document.getElementById("resultBox");
    const message = document.getElementById("msg");
    const targetLink = document.getElementById("targetLink");

    button.addEventListener("click", () => {
        const inputUrl = urlInput.value.trim();

        if (!inputUrl) {
            alert("Vui lòng dán một đường link vào ô, boss man!");
            return;
        }

        resultBox.classList.remove("hidden");
        message.textContent = "Đang phân tích link...";

        try {
            const parsed = new URL(inputUrl);
            
            // Đọc tham số đính kèm nếu link chứa dạng ?url= hoặc ?dest=
            const params = new URLSearchParams(parsed.search);
            const redirectUrl = params.get("url") || params.get("dest") || params.get("target") || params.get("redirect");

            if (redirectUrl) {
                message.textContent = "Đã trích xuất được link đích thành công!";
                targetLink.href = redirectUrl;
                targetLink.classList.remove("hidden");
            } else {
                message.textContent = "Link hợp lệ. Đang chuyển hướng...";
                targetLink.href = inputUrl;
                targetLink.classList.remove("hidden");
            }
        } catch (e) {
            message.textContent = "Đường link không đúng định dạng. Hãy kiểm tra lại, boss man!";
            targetLink.classList.add("hidden");
        }
    });
});
