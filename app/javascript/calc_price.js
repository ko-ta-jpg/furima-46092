document.addEventListener("turbo:load", setup);
document.addEventListener("turbo:render", setup);

function setup() {
  const priceInput = document.getElementById("item-price");
  const feeOut     = document.getElementById("add-tax-price");
  const profitOut  = document.getElementById("profit");
  if (!priceInput || !feeOut || !profitOut) return;

  const update = () => {
    const val = Number(priceInput.value);
    if (Number.isInteger(val)) {
      const fee = Math.floor(val * 0.1);
      const profit = Math.floor(val - fee);
      feeOut.textContent = isFinite(fee) ? fee : 0;
      profitOut.textContent = isFinite(profit) ? profit : 0;
    } else {
      feeOut.textContent = 0;
      profitOut.textContent = 0;
    }
  };

  priceInput.removeEventListener("input", update);
  priceInput.addEventListener("input", update);
  update();
}