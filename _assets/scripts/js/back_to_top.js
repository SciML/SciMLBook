window.onscroll = function () {
const btn = document.getElementById("backToTop");
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

document.addEventListener("DOMContentLoaded", function () {
const btn = document.getElementById("backToTop");
btn.addEventListener("click", function () {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
});
