   function calcularIMC(event) {
      event.preventDefault();
      const peso = document.getElementById("peso").value;
      const altura = document.getElementById("altura").value;
      const resultado = document.getElementById("resultado");
      const resultadoHidden = document.getElementById("resultadoHidden");

      if (peso === "" || altura === "") {
        resultado.innerHTML = "Preencha o peso e a altura.";
        return;
      }

      const imc = peso / (altura * altura);
      resultado.innerHTML = `Seu IMC é ${imc.toFixed(2).replace('.', ',')}.`;
resultadoHidden.value = imc.toFixed(2).replace('.', ',');

      // Envia os valores do IMC para o arquivo PHP e salva no banco de dados
      const xhttp = new XMLHttpRequest();
      xhttp.open("POST", "Php/calculadora_imc.php", true);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      const data = `peso=${peso}&altura=${altura}&resultado=${imc.toFixed(2)}`;
      xhttp.send(data);
    }