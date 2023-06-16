<?php
// Conexão com o banco de dados

$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "academia";

$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica a conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Consulta ao banco de dados
$sql = "SELECT aluno, plano, valor, vencimento, status FROM control_pagment";
$result = $conn->query($sql);

$payments = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $payment = array(
            'aluno' => $row['aluno'],
            'plano' => $row['plano'],
            'valor' => $row['valor'],
            'vencimento' => $row['vencimento'],
            'status' => $row['status']
        );
        $payments[] = $payment;
    }
}

// Retorna a resposta como JSON
header('Content-Type: application/json');
echo json_encode($payments);

$conn->close();
?>
