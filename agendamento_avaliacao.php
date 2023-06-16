<?php
    $servername = "localhost";
    $username = "root";
    $password = "1234";
    $dbname = "academia";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $names = ['maria', 'jane', 'roberto', 'aline'];
    $days = ['segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado'];

    foreach ($names as $name) {
        if (isset($_POST['horario_' . $name])) {
            $horarios = $_POST['horario_' . $name];
            $nome = $_POST['nome_' . $name];

            foreach ($horarios as $horario) {
                list($time, $day) = explode('-', $horario);

                $stmt = $conn->prepare("INSERT INTO agenda_avaliacao (nome, horario, $day) VALUES (?, ?, 1)");
                $stmt->bind_param("ss", $nome, $time); // Bind dos valores
                $stmt->execute();
            }
        }
    }

    // Adicionando código para retornar o último registro
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $result = $mysqli->query("SELECT * FROM avaliacoes ORDER BY idagend_avaliacao DESC");

        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            echo json_encode($row);
        } else {
            echo json_encode([]);
        }
        exit;
    }

    if (isset($stmt)) {
        $stmt->close();
    }

    $conn->close();
    header('Location: agendamento_avaliacao.html');
    exit; // Certifica-se de que o script seja encerrado após o redirecionamento
?>
