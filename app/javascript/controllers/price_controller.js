import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["price", "fee", "profit"]

  connect() {
    // ページ表示直後にも一度計算
    this.recalc()
  }

  recalc() {
    const input = this.priceTarget
    const feeOut = this.feeTarget
    const profitOut = this.profitTarget

    const digits = (input.value || "").replace(/[^\d]/g, "")

    if (digits === "") {
      feeOut.textContent = ""
      profitOut.textContent = ""
      return
    }

    const val = parseInt(digits, 10)
    if (Number.isFinite(val)) {
      const fee = Math.floor(val * 0.1)
      const profit = val - fee
      feeOut.textContent = String(fee)
      profitOut.textContent = String(profit)
    } else {
      feeOut.textContent = ""
      profitOut.textContent = ""
    }
  }
}