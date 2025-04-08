const aumentaFonteBotao = document.getElementById('aumentar-fonte');
const diminuiFonteBotao = document.getElementById('diminuir-fonte');
const alternaContraste = document.getElementById('alterna-contraste');
const botaoDeAcessibilidade = document.getElementById('botao-acessibilidade');
const opcoesDeAcessibilidade = document.getElementById('opcoes-acessibilidade');

alternaContraste.addEventListener('click', function () {
  document.body.classList.toggle('alto-contraste');
});

botaoDeAcessibilidade.addEventListener('click', function () {
  botaoDeAcessibilidade.classList.toggle('rotacao-botao');
  opcoesDeAcessibilidade.classList.toggle('apresenta-lista');

  const aberto = botaoDeAcessibilidade.getAttribute('aria-expanded') === 'true';
  botaoDeAcessibilidade.setAttribute('aria-expanded', !aberto);
});
