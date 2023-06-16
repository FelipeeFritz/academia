<?php
// Configurações de conexão com o banco de dados
$servername = "localhost"; // Nome do servidor do banco de dados
$username = "root"; // Nome de usuário do banco de dados
$password = "1234"; // Senha do banco de dados
$dbname = "academia"; // Nome do banco de dados

// Criação da conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica se a conexão foi estabelecida com sucesso
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Consulta SQL para buscar os registros
$sql = "SELECT matricula, nome, email, telefone FROM cadastro_aluno";

// Executa a consulta SQL
$result = $conn->query($sql);

// Array para armazenar os registros encontrados
$registros = array();

// Verifica se existem registros retornados pela consulta
if ($result->num_rows > 0) {
    // Loop através dos resultados da consulta
    while ($row = $result->fetch_assoc()) {
        $registros[] = $row;
    }
}

// Fecha a conexão com o banco de dados
$conn->close();

// Retorna os registros como um JSON
echo json_encode($registros);
?>
