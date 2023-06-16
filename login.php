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

// Obtendo os dados do formulário
$email = $_POST['email'];
$senha = $_POST['senha'];

// Verificando se o cadastro existe no sistema
$stmt = $conn->prepare("SELECT * FROM login WHERE email = ? AND senha = ?");
$stmt->bind_param("ss", $email, $senha);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Autenticação bem-sucedida
    $user = $result->fetch_assoc();
    
    // Verifica se 'admin' é uma substring do email do usuário
    if (stripos($email, 'admin') !== false) {
        echo '<script>alert("Login bem-sucedido."); window.location.href = "tela_principal.html";</script>';
    } else {
        echo '<script>alert("Login bem-sucedido."); window.location.href = "portal.html";</script>';
    }
} else {
    // Cadastro não encontrado, exibir mensagem de aviso
    echo '<script>alert("Cadastro não encontrado no sistema."); window.location.href = "login.html";</script>';
}

// Fechando a conexão com o banco de dados
$conn->close();
?>
