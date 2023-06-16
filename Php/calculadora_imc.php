<?php
// Verifica se a requisição foi feita usando o método POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Obtém os valores enviados pelo formulário
$peso = $_POST["peso"];
$altura = $_POST["altura"];
$resultado = str_replace(',', '.', $_POST["resultado"]);

  // Verifica se os valores estão vazios
  if (empty($peso) || empty($altura) || empty($resultado)) {
    echo "Preencha todos os campos.";
    exit;
  }

  // Conexão com o banco de dados
  $servername = "localhost";
  $username = "root";
  $password = "1234";
  $dbname = "academia";

  // Cria a conexão
  $conn = new mysqli($servername, $username, $password, $dbname);

  // Verifica se a conexão foi estabelecida com sucesso
  if ($conn->connect_error) {
    die("Falha na conexão com o banco de dados: " . $conn->connect_error);
  }

  // Prepara a instrução SQL e realiza a inserção dos valores na tabela
  $stmt = $conn->prepare("INSERT INTO calc_imc (peso, altura, resultado) VALUES (?, ?, ?)");
  $stmt->bind_param("dds", $peso, $altura, $resultado);

  // Executa a instrução SQL
  if ($stmt->execute()) {
    echo "Dados do IMC salvos com sucesso.";
  } else {
    echo "Erro ao salvar os dados do IMC: " . $stmt->error;
  }

  // Fecha a conexão com o banco de dados
  $stmt->close();
  $conn->close();
}
?>
