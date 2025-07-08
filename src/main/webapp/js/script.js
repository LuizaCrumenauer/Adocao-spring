/**
 * Função para controlar a navegação do carrossel de imagens.
 * @param {HTMLElement} element O botão (<a>) que foi clicado.
 * @param {number} n A direção do slide (-1 para anterior, 1 para próximo).
 */
function plusSlides(element, n) {
    // Encontra o 'carousel-container' mais próximo do botão que foi clicado.
    // Isso garante que cada carrossel funcione de forma independente.
    const carouselContainer = element.closest('.carousel-container');
    if (!carouselContainer) return;

    const slides = carouselContainer.getElementsByClassName("carousel-slide");
    if (slides.length <= 1) return; // Não faz nada se houver 1 ou 0 slides

    let currentSlideIndex = 0;
    // Encontra qual slide está ativo no momento
    for (let i = 0; i < slides.length; i++) {
        if (slides[i].classList.contains('active')) {
            currentSlideIndex = i;
            break;
        }
    }

    // Calcula o índice do novo slide
    let newSlideIndex = currentSlideIndex + n;

    // Lógica para fazer o carrossel ser circular (voltar ao início/fim)
    if (newSlideIndex >= slides.length) {
        newSlideIndex = 0;
    }
    if (newSlideIndex < 0) {
        newSlideIndex = slides.length - 1;
    }

    // Esconde o slide atual e mostra o novo
    slides[currentSlideIndex].classList.remove('active');
    slides[newSlideIndex].classList.add('active');
}