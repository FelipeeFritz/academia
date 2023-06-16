  const videos = [
  {
    src: 'videos/exercicio_peito.mp4', // Aqui foi alterado o caminho para o seu arquivo de vídeo
    title: 'Membros superiores',
    description: 'Os exercícios que trabalham tanto o peito quanto os membros superiores são comumente encontrados no treinamento de força e condicionamento físico. Eles geralmente envolvem movimentos de empurrar ou pressionar e podem incluir diversos exercícios .'
  },
  {
    src: 'videos/Treino POWER - Queimar gordura.mp4', // Aqui foi alterado o caminho para o seu arquivo de vídeo
    title: 'Treino POWER',
    description: 'O treino Power, também conhecido como treinamento de potência, envolve exercícios que são realizados em um ritmo rápido e com alta intensidade. Isso é ideal para queimar gordura porque o corpo precisa de muita energia para realizar esses movimentos, levando a um maior gasto calórico..'
  },
  {
    src: 'videos/Exercicios Abdomen Part II.mp4', // Aqui foi alterado o caminho para o seu arquivo de vídeo
    title: 'Exercício Abdominais',
    description: 'Exercícios abdominais são uma parte importante de um programa de treinamento físico, pois visam fortalecer e tonificar os músculos do abdômen. Além de contribuir para uma aparência mais definida..'
  },
  {
    src: 'videos/Exercicio Abdômen.mp4', // Aqui foi alterado o caminho para o seu arquivo de vídeo
    title: 'Exercício Abdominais Parte II',
    description: 'Exercícios abdominais são uma parte importante de um programa de treinamento físico, pois visam fortalecer e tonificar os músculos do abdômen. Além de contribuir para uma aparência mais definida..'
  },
  {
    src: 'videos/10 exercícios - Pratica em Casa.mp4', // Aqui foi alterado o caminho para o seu arquivo de vídeo
    title: '10 exercícios - Pratica em Casa',
    description: 'Os exercícios abdominais podem ser facilmente praticados em casa, sem a necessidade de equipamentos sofisticados. No video consta 10 exercicios para praticar em casa.'
  },
  {
    src: 'videos/Treino Intenso.mp4', // Aqui foi alterado o caminho para o seu arquivo de vídeo
    title: 'Treino Intenso',
    description: 'O treino intenso refere-se a uma forma de treinamento físico que envolve um alto nível de esforço e intensidade. É caracterizado por exercícios realizados com grande energia, carga ou volume.'
  },
];

const videosPerPage = 3;
let currentPage = 1;
let totalPages = Math.ceil(videos.length / videosPerPage);
let currentVideos = videos.slice(0, videosPerPage);

function renderVideos() {
  const videoGrid = document.getElementById('videoGrid');
  videoGrid.innerHTML = '';

  currentVideos.forEach((video) => {
    const videoWrapper = document.createElement('div');
    videoWrapper.classList.add('video-wrapper');

    const videoElement = document.createElement('div');
    videoElement.classList.add('video');

    const videoPlayer = document.createElement('video');
    videoPlayer.controls = true;
    videoPlayer.src = video.src;
    videoElement.appendChild(videoPlayer);

    const exerciseInfo = document.createElement('div');
    exerciseInfo.classList.add('exercise-info');

    const title = document.createElement('h2');
    title.textContent = video.title;
    exerciseInfo.appendChild(title);

    const description = document.createElement('p');
    description.textContent = video.description;
    exerciseInfo.appendChild(description);

    videoWrapper.appendChild(videoElement);
    videoWrapper.appendChild(exerciseInfo);
    videoGrid.appendChild(videoWrapper);
  });
}

function updatePaginationButtons() {
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');

  prevBtn.disabled = currentPage === 1;
  nextBtn.disabled = currentPage === totalPages;
}

function showPreviousPage() {
  if (currentPage > 1) {
    currentPage--;
    updateCurrentVideos();
    renderVideos();
    updatePaginationButtons();
  }
}

function showNextPage() {
  if (currentPage < totalPages) {
    currentPage++;
    updateCurrentVideos();
    renderVideos();
    updatePaginationButtons();
  }
}

function updateCurrentVideos() {
  const startIndex = (currentPage - 1) * videosPerPage;
  const endIndex = startIndex + videosPerPage;
  currentVideos = videos.slice(startIndex, endIndex);
}

document.getElementById('prevBtn').addEventListener('click', showPreviousPage);
document.getElementById('nextBtn').addEventListener('click', showNextPage);

// Renderiza os vídeos iniciais e atualiza os botões de paginação
renderVideos();
updatePaginationButtons();
