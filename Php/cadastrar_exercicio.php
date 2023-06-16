<?php
// Verificar se o método de requisição é POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Recuperar os dados enviados como JSON
    $jsonData = file_get_contents('php://input');
    $exerciseData = json_decode($jsonData, true);

    // Conectar ao banco de dados
    $host = 'localhost';
    $dbname = 'academia';
    $username = 'root';
    $password = '1234';

    try {
        $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Preparar a instrução SQL para inserir os registros
        $stmt = $conn->prepare('INSERT INTO treino (aparelho, serie, repeticao, carga, tipo_treino, cadastro_aluno_idcadastro) VALUES (?, ?, ?, ?, ?, ?)');

        // Inserir cada exercício na tabela
        foreach ($exerciseData as $exercise) {
            $aparelho = $exercise['aparelho'];
            $serie = $exercise['serie'];
            $repeticao = $exercise['repeticao'];
            $carga = $exercise['carga'];
            $tipoTreino = $exercise['tipo_treino'];
            $cadastroAlunoId = 1; // Defina o ID de cadastro do aluno adequado aqui

            $stmt->execute([$aparelho, $serie, $repeticao, $carga, $tipoTreino, $cadastroAlunoId]);
        }

        echo 'Registros salvos com sucesso.';
    } catch (PDOException $e) {
        echo 'Erro ao salvar os registros: ' . $e->getMessage();
    }

    // Fechar a conexão
    $conn = null;
} else {
    echo 'Método não permitido.';
}
?>
