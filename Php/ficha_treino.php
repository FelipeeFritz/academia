<?php
// Configurações de conexão com o banco de dados
$servername = "localhost"; // Nome do servidor
$username = "root"; // Nome de usuário do banco de dados
$password = "1234"; // Senha do banco de dados
$dbname = "academia"; // Nome do banco de dados

// Estabelece a conexão com o banco de dados
$connection = mysqli_connect($servername, $username, $password, $dbname);

// Verifica se a conexão foi estabelecida com sucesso
if (!$connection) {
    die("Falha na conexão com o banco de dados: " . mysqli_connect_error());
}

// Recupera os dados da tabela treino
$query = "SELECT * FROM treino";
$result = mysqli_query($connection, $query);

// Verifica se há registros retornados
if (mysqli_num_rows($result) > 0) {
    // Inicia a construção da tabela HTML
    $tableHTML = '<table>
                    <tr>
                        <th>Exercício</th>
                        <th>Série</th>
                        <th>Repetição</th>
                        <th>Carga</th>
                        <th>Tipo de Treino</th>
                    </tr>';

    // Itera por cada registro de dados
    while ($row = mysqli_fetch_assoc($result)) {
        // Adiciona uma nova linha na tabela para cada registro
        $tableHTML .= '<tr>
                          <td>' . $row['aparelho'] . '</td>
                          <td>' . $row['serie'] . '</td>
                          <td>' . $row['repeticao'] . '</td>
                          <td>' . $row['carga'] . '</td>
                          <td>' . $row['tipo_treino'] . '</td>
                      </tr>';
    }

    // Fecha a tabela HTML
    $tableHTML .= '</table>';
} else {
    // Nenhum registro encontrado
    $tableHTML = '<p>Nenhum registro encontrado.</p>';
}

// Fecha a conexão com o banco de dados
mysqli_close($connection);

// Exibe a tabela HTML
echo $tableHTML;
?>
