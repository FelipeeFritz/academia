<?php
// Configurações do banco de dados
$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "academia";

// Criar conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar a conexão
if ($conn->connect_error) {
    die("Falha na conexão com o banco de dados: " . $conn->connect_error);
}

// Verificar se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obter os valores do formulário
    $nome = $_POST["nome"];
    $sobrenome = $_POST["sobrenome"];
    $telefone = $_POST["telefone"];
    $dataNascimento = $_POST["ano"] . "-" . $_POST["mes"] . "-" . $_POST["dia"];
    $rg = $_POST["rg"];
    $cpf = $_POST["cpf"] . $_POST["cpf2"];
    $rua = $_POST["rua"];
    $numero = $_POST["numero"];
    $bairro = $_POST["bairro"];
    $estado = $_POST["estado"];
    $cidade = $_POST["cidade"];
    $cep = $_POST["cep"] . $_POST["cep2"];
    $email = $_POST["email"];
    $login = $_POST["login"];
    $senha = $_POST["pass"];

    // Gerar matrícula automática com valores aleatórios de até 6 dígitos
    $matricula = str_pad(rand(1, 999999), 6, '0', STR_PAD_LEFT);

    // Crie a consulta SQL para inserir os dados no banco de dados
    $sql = "INSERT INTO cadastro_aluno (nome, sobrenome, telefone, data_nascimento, rg, cpf, rua, numero, bairro, estado, cidade, cep, email, login, senha, matricula) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // Preparar a consulta SQL
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssssssssssssss", $nome, $sobrenome, $telefone, $dataNascimento, $rg, $cpf, $rua, $numero, $bairro, $estado, $cidade, $cep, $email, $login, $senha, $matricula);

    // Executar a consulta SQL
    if ($stmt->execute()) {
        echo "Dados do aluno foram salvos com sucesso!";

        // Prepare a consulta SQL para inserir os dados na tabela de login
        $sql = "INSERT INTO login (email, senha) VALUES (?, ?)";

        // Preparar a consulta SQL
        $stmtLogin = $conn->prepare($sql);
        $stmtLogin->bind_param("ss", $email, $senha);
        
        // Execute a consulta SQL
        if ($stmtLogin->execute()) {
            echo "Dados de login foram salvos com sucesso!";
        } else {
            echo "Erro ao salvar os dados de login: " . $stmtLogin->error;
        }
        $stmtLogin->close();
    } else {
        echo "Erro ao salvar os dados do aluno: " . $stmt->error;
    }
    $stmt->close();
}

// Fechar a conexão com o banco de dados
$conn->close();
header('Location: cadastro_alunos.html');
?>
