document.addEventListener('turbo:load', () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  // 公開鍵メタタグから取得
  const meta = document.querySelector('meta[name="payjp-public-key"]');
  const publicKey = meta ? meta.content : null;
  if (!publicKey || typeof Payjp === 'undefined') return;

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // ---- Elements をマウント ----
  // 1) カード番号
  const numberElement = elements.create('cardNumber', {
    placeholder: '4242 4242 4242 4242',
    style: {
      base: {
        'font-size': '16px',
        'letter-spacing': '0.03em',
      },
    },
  });
  numberElement.mount('#number-form');

  // 2) 有効期限（MM/YY）
  const expiryElement = elements.create('cardExpiry', {
    placeholder: 'MM/YY',
    style: {
      base: {
        'font-size': '16px',
      },
    },
  });
  expiryElement.mount('#expiry-form');

  // 3) CVC
  const cvcElement = elements.create('cardCvc', {
    placeholder: '123',
    style: {
      base: {
        'font-size': '16px',
      },
    },
  });
  cvcElement.mount('#cvc-form');

  // ---- 送信時にトークン化 ----
  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    // Elements の cardNumber 要素を指定してトークン化
    const { id: token, error } = await payjp.createToken(numberElement);
    if (error) {
      alert(error.message || 'カード情報を確認してください');
      return;
    }

    // hiddenでトークンをフォームに追加
    const hidden = document.createElement('input');
    hidden.type = 'hidden';
    hidden.name = 'token';
    hidden.value = token;
    form.appendChild(hidden);

    // 念のため、Elementsの表示値はそのままでもnameが無いので送信されません
    form.submit();
  });
});