<?php

$servername = "localhost";
$username = "root";
$password = "1234";
$database = "academia";

// Cria a conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $database);

// Verifica se houve algum erro na conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

if(isset($_POST['horarios']) && is_array($_POST['horarios'])) {

    foreach($_POST['horarios'] as $horarioCompleto) {
        $parts = explode('-', $horarioCompleto);
        $dia = $parts[0];
        $horario = $parts[1];

        // Inicializa a presença com zeros
        $presenca = [0, 0, 0, 0, 0];
        $indices = ['seg' => 0, 'terca' => 1, 'qua' => 2, 'qui' => 3, 'sex' => 4];

        // Se o dia estiver presente em $indices, atualiza o valor correspondente em $presenca
        if(array_key_exists($dia, $indices)) {
            $presenca[$indices[$dia]] = 1;
        }

        // Consulta para verificar se o horário já existe
        $check_sql = "SELECT * FROM `controle_frequencia` WHERE `horario` = ?";
        $check_stmt = $conn->prepare($check_sql);
        $check_stmt->bind_param("s", $horario);

        $check_stmt->execute();
        $check_result = $check_stmt->get_result();

        // Se o resultado for maior que 0, o horário já foi marcado
        if ($check_result->num_rows > 0) {
            echo "Você já tem um agendamento marcado.";
            continue;
        }

        // Define o comando SQL para inserir os dados na tabela
        $sql = "INSERT INTO `controle_frequencia` (`horario`, `segunda`, `terca`, `quarta`, `quinta`, `sexta`) 
            VALUES (?, ?, ?, ?, ?, ?)";

        // Prepara a declaração SQL com parâmetros
        $stmt = $conn->prepare($sql);

        // O valor padrão para cada dia será 0 se nenhum valor for fornecido em $_POST['horarios'] para aquele dia
        $stmt->bind_param("siiiii", $horario, $presenca[0], $presenca[1], $presenca[2], $presenca[3], $presenca[4]);

        // Executa a declaração SQL
        if (!$stmt->execute()) {
            echo "Erro ao inserir dados: " . $stmt->error;
        } else {
            echo "Dados inseridos com sucesso!";
        }

        // Fecha a declaração
        $stmt->close();
    }
}

// Fecha a conexão com o banco de dados
$conn->close();

?>
