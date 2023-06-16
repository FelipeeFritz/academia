<?php
// Dados de conexão com o banco de dados
$servername = "localhost"; // Nome do servidor
$username = "root"; // Nome de usuário do banco de dados
$password = "1234"; // Senha do banco de dados
$dbname = "academia"; // Nome do banco de dados

// Dados do formulário
$nome = $_POST['nome'];
$sobrenome = $_POST['sobrenome'];
$data_nascimento = $_POST['ano'] . '-' . $_POST['mes'] . '-' . $_POST['dia'];
$rg = $_POST['rg'];
$cpf = $_POST['cpf'] . $_POST['cpf2'];
$rua = $_POST['rua'];
$numero = $_POST['numero'];
$bairro = $_POST['bairro'];
$estado = $_POST['estado'];
$cidade = $_POST['cidade'];
$cep = $_POST['cep'] . $_POST['cep2'];
$email = $_POST['email'];
$telefone = isset($_POST['telefone']) ? $_POST['telefone'] : '';
$login = $_POST['login'];
$senha = $_POST['pass'];
$matricula = ""; // Você pode adicionar a lógica para gerar a matrícula aqui

// Criar conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar se houve um erro na conexão
if ($conn->connect_error) {
    die("Falha na conexão com o banco de dados: " . $conn->connect_error);
}

// Preparar a consulta SQL
$sql = "INSERT INTO cadastro_instrutor (nome, sobrenome, data_nascimento, rg, cpf, rua, numero, bairro, estado, cidade, cep, email, telefone, login, senha, matricula)
        VALUES ('$nome', '$sobrenome', '$data_nascimento', '$rg', '$cpf', '$rua', '$numero', '$bairro', '$estado', '$cidade', '$cep', '$email', '$telefone', '$login', '$senha', '$matricula')";

// Executar a consulta SQL
if ($conn->query($sql) === TRUE) {
    echo "Registro salvo com sucesso!";
} else {
    echo "Erro ao salvar o registro: " . $conn->error;
}

// Fechar a conexão com o banco de dados
$conn->close();
header('Location: cadastro_instrutores.html');
?>
