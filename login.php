<?php
// Dados de conexão com o banco de dados
$servername = "localhost"; // Nome do servidor
$username = "root"; // Nome de usuário do MySQL
$password = "1234"; // Senha do MySQL
$dbname = "academia"; // Nome do banco de dados

// Criando uma conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificando a conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Obtendo os dados do formulário de login
$email = $_POST['email'];
$senha = $_POST['senha'];

// Preparar a consulta SQL para buscar a senha criptografada
$stmt = $conn->prepare("SELECT senha FROM login WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) { // Verifica se algum registro foi encontrado
    $row = $result->fetch_assoc();
    $senhaCriptografada = $row['senha'];

    // Verificar se a senha fornecida é igual à senha criptografada
    if ($senha === $senhaCriptografada) {
        // Autenticação bem-sucedida
        // Verifica se 'admin' é uma substring do email do usuário
        if (stripos($email, 'admin') !== false) {
            echo '<script>alert("Login bem-sucedido."); window.location.href = "tela_principal.html";</script>';
        } else {
            echo '<script>alert("Login bem-sucedido."); window.location.href = "portal.html";</script>';
        }
    } else {
        // Senha incorreta, exibir mensagem de aviso
        echo '<script>alert("Senha incorreta."); window.location.href = "login.html";</script>';
    }
} else {
    // Cadastro não encontrado, exibir mensagem de aviso
    echo '<script>alert("Cadastro não encontrado no sistema."); window.location.href = "login.html";</script>';
}

// Fechando a conexão com o banco de dados
$stmt->close();
$conn->close();
?>
