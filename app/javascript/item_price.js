document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (isNaN(price)) {
      taxPrice.textContent = "";
      profit.textContent = "";
      return;
    }

    const fee = Math.floor(price * 0.1);
    const gain = price - fee;

    taxPrice.textContent = fee;
    profit.textContent = gain;
  });
});