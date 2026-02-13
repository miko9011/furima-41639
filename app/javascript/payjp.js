document.addEventListener("turbo:load", () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  // すでにiframeがあれば何もしない（再描画対策）
  if (document.querySelector("#number-form iframe")) return;

  const payjp = Payjp("pk_test_f39efdc0c599e7612da29366");
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  numberElement.mount("#number-form");

  const expiryElement = elements.create("cardExpiry");
  expiryElement.mount("#expiry-form");

  const cvcElement = elements.create("cardCvc");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {

      if (!response.error) {
        const tokenInput = document.createElement("input");
        tokenInput.type = "hidden";
        tokenInput.name = "token";
        tokenInput.value = response.id;
        form.appendChild(tokenInput);
      }

      // エラーでもRailsへ送る
      form.submit();
    });
  });
});