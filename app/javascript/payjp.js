document.addEventListener("turbo:load", () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  // iframe多重生成防止
  if (document.querySelector("#number-form iframe")) return;

  // ✅ 公開鍵は環境変数から
  const payjp = Payjp("<%= ENV['PAYJP_PUBLIC_KEY'] %>");
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

      // ❌ エラー時は送信しない
      if (response.error) {
        alert(response.error.message);
        return;
      }

      // ✅ トークンをhiddenで送信
      const tokenInput = document.createElement("input");
      tokenInput.type = "hidden";
      tokenInput.name = "token";
      tokenInput.value = response.id;
      form.appendChild(tokenInput);

      // ✅ カード情報クリア（レビュー指摘対応）
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      // ✅ 正常時のみRailsへ送信
      form.submit();
    });
  });
});