document.addEventListener("turbo:load", setupPayjp);
document.addEventListener("turbo:render", setupPayjp);

function setupPayjp() {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (document.querySelector("#number-form iframe")) return;

  if (!gon || !gon.public_key) {
    console.error("PAYJP public key is missing");
    return;
  }

  const payjp = Payjp(gon.public_key);
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
      if (response.error) {
        alert(response.error.message);
        return;
      }

      const tokenInput = document.createElement("input");
      tokenInput.type = "hidden";
      tokenInput.name = "token";
      tokenInput.value = response.id;
      form.appendChild(tokenInput);

      form.submit();
    });
  });
}