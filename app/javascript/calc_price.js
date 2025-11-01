document.addEventListener("turbo:load", setup);
document.addEventListener("turbo:render", setup);

function setup() {
  const priceInput = document.getElementById("item-price");
  const feeOut     = document.getElementById("add-tax-price");
  const profitOut  = document.getElementById("profit");
  if (!priceInput || !feeOut || !profitOut) return;

<<<<<<< Updated upstream
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
=======
  // 既にバインド済みならイベントは追加しない
  if (!priceInput.dataset.bound) {
    priceInput.addEventListener("input", onInput);
    priceInput.dataset.bound = "true";
  }

  // 初回/再描画時にも必ず表示を更新
  onInput();

  function onInput() {
    // 半角数値のみを想定（全角や文字混じりは NaN → 0 表示）
    const v = Number(priceInput.value);
    if (Number.isFinite(v)) {
      const fee    = Math.floor(v * 0.1);
      const profit = Math.floor(v - fee);
      feeOut.textContent    = fee >= 0 ? fee : 0;
      profitOut.textContent = profit >= 0 ? profit : 0;
    } else {
      feeOut.textContent    = 0;
      profitOut.textContent = 0;
    }
  }
>>>>>>> Stashed changes
}