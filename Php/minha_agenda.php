<?php
// Define o fuso horário padrão
date_default_timezone_set('America/Sao_Paulo');

// Conexão com o banco de dados (substitua os valores conforme necessário)
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

// Executa a consulta SQL para obter os dados, com a conversão para os nomes "Agendado" e "Não Agendado"
$sqlConsulta = "SELECT horario, 
               CASE WHEN segunda = 1 THEN 'Agendado' ELSE 'Não Agendado' END AS segunda,
               CASE WHEN terca = 1 THEN 'Agendado' ELSE 'Não Agendado' END AS terca,
               CASE WHEN quarta = 1 THEN 'Agendado' ELSE 'Não Agendado' END AS quarta,
               CASE WHEN quinta = 1 THEN 'Agendado' ELSE 'Não Agendado' END AS quinta,
               CASE WHEN sexta = 1 THEN 'Agendado' ELSE 'Não Agendado' END AS sexta
        FROM controle_frequencia
		ORDER BY idcontrole_frequencia DESC
		LIMIT 1";
$result = $conn->query($sqlConsulta);

// Verifica se há registros retornados
if ($result->num_rows > 0) {
    // Cria um array para armazenar os dados
    $dados = array();

    // Loop através dos registros retornados
    while ($row = $result->fetch_assoc()) {
        // Converte o horário para o formato de 24 horas
        $row['horario'] = date("H:i", strtotime($row['horario']));

        // Adiciona o registro ao array
        $dados[] = $row;
    }

    // Retorna os dados como JSON
    header('Content-Type: application/json');
    echo json_encode($dados);
} else {
    // Retorna uma resposta vazia
    echo '[]';
}

// Fecha a conexão com o banco de dados
$conn->close();
?>
