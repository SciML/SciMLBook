document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("backToTop");

    window.onscroll = function () {
        const isVisible = btn.style.display === "block";

        if (
            document.body.scrollTop > 300 ||
            document.documentElement.scrollTop > 300
        ) {
            if (!isVisible) {
                btn.style.display = "block";
                btn.classList.add("pulse-once");
                setTimeout(() => btn.classList.remove("pulse-once"), 600);
            }
        } else {
            btn.style.display = "none";
        }
    };

    btn.addEventListener("click", function () {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });
});
