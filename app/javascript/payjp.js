document.addEventListener('turbo:load', () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const meta = document.querySelector('meta[name="payjp-public-key"]');
  const publicKey = meta ? meta.content : null;
  if (!publicKey) return;

  const payjp = Payjp(publicKey);

  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener('submit', async (e) => {
    const hiddenToken = document.getElementById('card-token');
    if (hiddenToken && hiddenToken.value) return;

    e.preventDefault();
    try {

    const result = await payjp.createToken(numberElement);

    if (result.error) {
      form.submit();
      return;
    }

    const token = result.id;
    if (hiddenToken) {
      hiddenToken.value = token;
    }

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      form.submit();
    } catch (err) {
      console.error(err);
      alert('カード情報の送信中にエラーが発生しました。時間をおいて再度お試しください。');
    }
  });
});