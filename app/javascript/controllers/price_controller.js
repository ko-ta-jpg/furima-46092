import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["price", "fee", "profit"];

  connect() {
    // 画面表示時にも一度計算
    this.recalc();
  }

  recalc() {
    const raw = this.priceTarget.value || "";
    const digits = raw.replace(/[^\d]/g, ""); // 数字以外除去
    if (digits === "") {
      this.feeTarget.textContent = "";
      this.profitTarget.textContent = "";
      return;
    }
    const val = parseInt(digits, 10);
    if (Number.isFinite(val)) {
      const fee = Math.floor(val * 0.1);
      const profit = val - fee;
      this.feeTarget.textContent = String(fee);
      this.profitTarget.textContent = String(profit);
    } else {
      this.feeTarget.textContent = "";
      this.profitTarget.textContent = "";
    }
  }
}