<?php
require 'conexao.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['token'])) {
    $token = $_GET['token'];

    // Verifica se o token é válido e não expirou
    $stmt = $pdo->prepare("SELECT user_id, expires_at FROM password_resets WHERE token = ?");
    $stmt->execute([$token]);
    $reset = $stmt->fetch();

    if ($reset && new DateTime() < new DateTime($reset['expires_at'])) {
        // Exibe o formulário de redefinição
        echo '
        <form action="reset_password.php" method="post">
            <input type="hidden" name="token" value="'.$token.'">
            <label for="password">Nova senha:</label>
            <input type="password" name="password" id="password" required>
            <input type="submit" value="Redefinir senha">
        </form>';
    } else {
        echo "Link de redefinição inválido ou expirado.";
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $token = $_POST['token'];
    $new_password = password_hash($_POST['password'], PASSWORD_BCRYPT);

    // Verifica o token novamente
    $stmt = $pdo->prepare("SELECT user_id FROM password_resets WHERE token = ?");
    $stmt->execute([$token]);
    $reset = $stmt->fetch();

    if ($reset) {
        // Atualiza a senha do usuário
        $stmt = $pdo->prepare("UPDATE usuarios SET senha = ? WHERE id = ?");
        $stmt->execute([$new_password, $reset['user_id']]);

        // Remove o token após a redefinição
        $stmt = $pdo->prepare("DELETE FROM password_resets WHERE token = ?");
        $stmt->execute([$token]);

        echo "Senha redefinida com sucesso!";
    } else {
        echo "Falha ao redefinir a senha.";
    }
}
?>