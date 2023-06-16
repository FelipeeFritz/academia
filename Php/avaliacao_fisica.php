<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $host = 'localhost';
    $dbname = 'academia';
    $username = 'root';
    $password = '1234';

    try {
        // Conectar ao banco de dados
        $conexao = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $conexao->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Obter os valores do formulário
        $braco = $_POST['braco'];
        $antebraco = $_POST['antebraco'];
        $peito = $_POST['peito'];
        $cintura = $_POST['cintura'];
        $quadril = $_POST['quadril'];
        $coxa = $_POST['coxa'];
        $panturrilha = $_POST['panturrilha'];
        $altura = $_POST['altura'];
        $peso = $_POST['peso'];

        // Supondo que você tenha o ID do aluno e do treino disponíveis em variáveis
        $idAluno = 1; // Atribua o valor do ID do aluno aqui
        $idTreino = 1; // Atribua o valor do ID do treino aqui

        // Inserir os dados na tabela avaliacao_fisica
        $sql = 'INSERT INTO avaliacao_fisica (braco, antebraco, peito, cintura, quadril, coxa, panturrilha, altura, peso, cadastro_aluno_idcadastro, treino_idtreino) 
                VALUES (:braco, :antebraco, :peito, :cintura, :quadril, :coxa, :panturrilha, :altura, :peso, :cadastro_aluno_idcadastro, :treino_idtreino)';
        $stmt = $conexao->prepare($sql);
        $stmt->bindParam(':braco', $braco, PDO::PARAM_STR);
        $stmt->bindParam(':antebraco', $antebraco, PDO::PARAM_STR);
        $stmt->bindParam(':peito', $peito, PDO::PARAM_STR);
        $stmt->bindParam(':cintura', $cintura, PDO::PARAM_STR);
        $stmt->bindParam(':quadril', $quadril, PDO::PARAM_STR);
        $stmt->bindParam(':coxa', $coxa, PDO::PARAM_STR);
        $stmt->bindParam(':panturrilha', $panturrilha, PDO::PARAM_STR);
        $stmt->bindParam(':altura', $altura, PDO::PARAM_STR);
        $stmt->bindParam(':peso', $peso, PDO::PARAM_STR);
        $stmt->bindParam(':cadastro_aluno_idcadastro', $idAluno, PDO::PARAM_INT);
        $stmt->bindParam(':treino_idtreino', $idTreino, PDO::PARAM_INT);
        $stmt->execute();

        echo "Dados salvos com sucesso!";
    } catch (PDOException $e) {
        echo 'Erro na conexão com o banco de dados: ' . $e->getMessage();
    }
}
?>
