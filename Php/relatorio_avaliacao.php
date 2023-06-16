<?php
// Conectar no banco de dados
$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "academia";

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Checar conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Realizar consulta SQL
$sql = "SELECT * FROM avaliacao_fisica ORDER BY idavaliacao_fisica DESC LIMIT 3";
$result = $conn->query($sql);

$data = []; // Vamos armazenar os resultados aqui

if ($result->num_rows > 0) {
    // Saída de cada linha
    while($row = $result->fetch_assoc()) {
        $data[] = [
            'id' => $row["idavaliacao_fisica"],
            'braco' => $row["braco"],
            'antebraco' => $row["antebraco"],
            'peito' => $row["peito"],
            'cintura' => $row["cintura"],
            'quadril' => $row["quadril"],
            'coxa' => $row["coxa"],
            'panturrilha' => $row["panturrilha"],
            'altura' => $row["altura"],
            'peso' => $row["peso"],
        ];
    }
} else {
    $data = ['error' => '0 resultados'];
}

$conn->close();

// Retornar a resposta como JSON
header('Content-Type: application/json');
echo json_encode($data);
?>
