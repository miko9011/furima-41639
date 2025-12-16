const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const priceValue = parseInt(priceInput.value, 10);
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (isNaN(priceValue)) {
      taxPrice.textContent = "";
      profit.textContent = "";
      return;
    }

    const fee = Math.floor(priceValue * 0.1);
    const gain = priceValue - fee;

    taxPrice.textContent = fee;
    profit.textContent = gain;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price)