const setupPayjpForm = () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const meta = document.querySelector('meta[name="payjp-public-key"]');
  const publicKey = meta ? meta.content : null;
  if (!publicKey) return;

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement   = elements.create('cardCvc');

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
        console.error(result.error);
        form.submit();
        return;
      }

      if (hiddenToken) {
        hiddenToken.value = result.id;
      }

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      form.submit();
    } catch (err) {
      console.error(err);
      form.submit(); 
    }
  });
};

document.addEventListener('turbo:load',   setupPayjpForm);
document.addEventListener('turbo:render', setupPayjpForm);
