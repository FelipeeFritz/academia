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
$newPassword = $_POST['new-password'];

// Atualizar a senha no banco de dados
$sqlUpdate = "UPDATE login SET senha = '$newPassword' WHERE email = '$email'";
if ($conn->query($sqlUpdate) === TRUE) {
    // Senha atualizada com sucesso
    echo '<script>alert("Senha redefinida com sucesso."); window.location.href = "login.html";</script>';
} else {
    // Falha ao atualizar a senha
    echo '<script>alert("Falha ao atualizar a senha. Por favor, tente novamente mais tarde."); window.location.href = "redefinir_senha.html";</script>';
}

// Fechando a conexão com o banco de dados
$conn->close();
?>
