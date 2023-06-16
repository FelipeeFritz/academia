<?php
// Configurações do banco de dados
$host = 'localhost';
$db = 'academia';
$user = 'root';
$password = '1234';

// Estabelece a conexão com o banco de dados
$mysqli = new mysqli($host, $user, $password, $db);

// Verifica se houve algum erro na conexão
if ($mysqli->connect_errno) {
    echo json_encode(['error' => 'Falha ao conectar ao banco de dados: ' . $mysqli->connect_error]);
    exit();
}

// Consulta SQL para recuperar os dados
$query = "SELECT * FROM histor_pagamento";
$result = $mysqli->query($query);

// Verifica se a consulta retornou algum resultado
if ($result->num_rows > 0) {
    $payments = [];

    // Loop pelos resultados da consulta
    while ($row = $result->fetch_assoc()) {
        $payments[] = $row;
    }

    // Retorna os pagamentos como JSON
    echo json_encode($payments);
} else {
    echo json_encode(['error' => 'Nenhum resultado encontrado.']);
}

// Fecha a conexão com o banco de dados
$mysqli->close();
?>
