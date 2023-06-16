<?php
// Configurações do banco de dados
$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "academia";

// Conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Erro de conexão com o banco de dados: " . $conn->connect_error);
}

// Consulta SQL para recuperar os registros
$sql = "SELECT nome, data, hora FROM regis_avaliacao";
$result = $conn->query($sql);

// Verifica se há registros retornados
if ($result->num_rows > 0) {
    // Início da tabela HTML
    $html = '<tr>
                <th>Nome</th>
                <th>Data</th>
                <th>Hora</th>
            </tr>';

    // Loop através dos registros retornados
    while ($row = $result->fetch_assoc()) {
        $html .= '<tr>';
        $html .= '<td>' . $row['nome'] . '</td>';
        $html .= '<td>' . $row['data'] . '</td>';
        $html .= '<td>' . $row['hora'] . '</td>';
        $html .= '</tr>';
    }

    echo $html; // Retorna o HTML gerado
} else {
    echo 'Nenhum registro encontrado.';
}

// Fechar a conexão com o banco de dados
$conn->close();
?>
