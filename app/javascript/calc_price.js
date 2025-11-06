(() => {
  const boot = () => {
    const priceInput = document.querySelector("#item-price");
    const feeOut     = document.querySelector("#add-tax-price");
    const profitOut  = document.querySelector("#profit");

    if (!priceInput || !feeOut || !profitOut) return;

    const recalc = () => {
      const digits = (priceInput.value || "").replace(/[^\d]/g, "");
      if (digits === "") {
        feeOut.textContent = "";
        profitOut.textContent = "";
        return;
      }

      const val = parseInt(digits, 10);
      if (Number.isFinite(val)) {
        const fee    = Math.floor(val * 0.1);
        const profit = val - fee;
        feeOut.textContent    = String(fee);
        profitOut.textContent = String(profit);
      } else {
        feeOut.textContent = "";
        profitOut.textContent = "";
      }
    };

    priceInput.addEventListener("input", recalc);
    recalc();
  };

  window.addEventListener("turbo:load", boot);
  window.addEventListener("DOMContentLoaded", boot);
})();
