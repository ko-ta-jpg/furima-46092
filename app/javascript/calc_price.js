(() => {
  const boot = () => {
    console.log("[calc_price] loaded"); // 読み込み確認

    const priceInput = document.querySelector("#item-price");
    const feeOut     = document.querySelector("#add-tax-price");
    const profitOut  = document.querySelector("#profit");

    if (!priceInput || !feeOut || !profitOut) {
      console.log("[calc_price] elements not found");
      return;
    }

    const recalc = () => {
      const raw = priceInput.value ?? "";
      const digits = raw.replace(/[^\d]/g, ""); // 数字以外除去
      if (digits === "") {
        feeOut.textContent = "0";
        profitOut.textContent = "0";
        return;
      }
      const val = parseInt(digits, 10);
      if (Number.isFinite(val)) {
        const fee    = Math.floor(val * 0.1);
        const profit = val - fee;
        feeOut.textContent    = String(fee);
        profitOut.textContent = String(profit);
      } else {
        feeOut.textContent = "0";
        profitOut.textContent = "0";
      }
    };

    // 入力時に再計算（IME対策でkeyupも）
    priceInput.addEventListener("input", recalc);
    priceInput.addEventListener("keyup", recalc);

    // 初期表示でも計算
    recalc();
  };

  // Turbo/通常どちらでも発火
  document.addEventListener("turbo:load",  boot);
  document.addEventListener("turbo:render", boot);
  document.addEventListener("DOMContentLoaded", boot);
})();