document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById("item-price");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = priceInput.value;
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    // 空欄のとき
    if (price === "" || isNaN(price)) {
      taxPrice.innerHTML = "";
      profit.innerHTML = "";
      return;
    }

    const fee = Math.floor(price * 0.1);
    const gain = Math.floor(price - fee);

    taxPrice.innerHTML = fee;
    profit.innerHTML = gain;
  });
});
