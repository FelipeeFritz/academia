        window.onload = function() {
            document.querySelector('#avaliacao-form').addEventListener('submit', function(event) {
                event.preventDefault();

                var form = event.target;
                var data = new FormData(form);

                var results = document.querySelector('#results');
                results.innerHTML = '';
				                var div = document.createElement('div');
                div.style.display = 'flex';
                div.style.flexDirection = 'row';
                div.style.justifyContent = 'space-between';
                var ul = document.createElement('ul');

                for (var pair of data.entries()) {
                    var key = pair[0];
                    var value = pair[1];

                    var li = document.createElement('li');
                    var description = '';
                    switch(key) {
                        case 'braco':
                            description = 'A circunferência do braço é ';
                            break;
                        case 'antebraco':
                            description = 'A circunferência do antebraço é ';
                            break;
                        case 'peito':
                            description = 'A circunferência do peito é ';
                            break;
                        case 'cintura':
                            description = 'A circunferência da cintura é ';
                            break;
                        case 'quadril':
                            description = 'A circunferência do quadril é ';
                            break;
                        case 'coxa':
                            description = 'A circunferência da coxa é ';
                            break;
                        case 'panturrilha':
                            description = 'A circunferência da panturrilha é ';
                            break;
                        case 'altura':
                            description = 'A altura é ';
                            break;
                        case 'peso':
                            description = 'O peso corporal é ';
                            break;
                    }
                    li.textContent = description + value + (key === 'peso' ? ' kg.' : ' cm.');
                    ul.appendChild(li);
                }

                var img = document.createElement('img');
                img.src = 'avaliacao.jpg';
                img.alt = 'Descrição da imagem';
                img.style.width = '30%';

                div.appendChild(ul);
                div.appendChild(img);
                results.appendChild(div);

                // Envie os dados para o arquivo PHP usando AJAX
                var xhr = new XMLHttpRequest();
                xhr.open('POST', form.action, true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                        console.log(xhr.responseText);  // Opcional: exiba a resposta do servidor
                    }
                };
                xhr.send(data);
            });
        };