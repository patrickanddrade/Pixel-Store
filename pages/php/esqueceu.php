<?php
// Conexão com o banco de dados
require 'conexao.php'; // Substitua pelo seu arquivo de conexão

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);

    // Verifica se o e-mail existe no banco de dados
    $stmt = $pdo->prepare("SELECT id FROM usuarios WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user) {
        // Gera token único e data de expiração (1 hora)
        $token = bin2hex(random_bytes(50));
        $expires_at = date('Y-m-d H:i:s', strtotime('+1 hour'));

        // Armazena o token no banco de dados
        $stmt = $pdo->prepare("INSERT INTO password_resets (user_id, token, expires_at) VALUES (?, ?, ?)");
        $stmt->execute([$user['id'], $token, $expires_at]);

        // Cria o link de redefinição
        $reset_link = "https://seusite.com/reset_password.php?token=" . $token;

        // Envia o e-mail
        $to = $email;
        $subject = "Redefinição de senha";
        $message = "Clique no link para redefinir sua senha: " . $reset_link;
        $headers = "From: no-reply@seusite.com";

        if (mail($to, $subject, $message, $headers)) {
            echo "Um link de redefinição de senha foi enviado para o seu e-mail.";
        } else {
            echo "Falha ao enviar o e-mail.";
        }
    } else {
        echo "E-mail não encontrado.";
    }
}
?>