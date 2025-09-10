const express = require('express');
const { query } = require('../config/database');
const { generateToken, verifyPassword, hashPassword, authenticateToken } = require('../middleware/auth');
const router = express.Router();

// POST /api/auth/login - Fazer login
router.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    // Validar dados de entrada
    if (!username || !password) {
      return res.status(400).json({
        error: 'Username e senha são obrigatórios',
        code: 'MISSING_CREDENTIALS'
      });
    }

    // Buscar administrador no banco
    const result = await query(
      'SELECT id, username, password_hash, role FROM admin_users WHERE username = $1',
      [username]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        error: 'Credenciais inválidas',
        code: 'INVALID_CREDENTIALS'
      });
    }

    const admin = result.rows[0];

    // Verificar senha
    const isValidPassword = await verifyPassword(password, admin.password_hash);
    
    if (!isValidPassword) {
      return res.status(401).json({
        error: 'Credenciais inválidas',
        code: 'INVALID_CREDENTIALS'
      });
    }

    // Gerar token JWT
    const token = generateToken(admin.id);

    // Retornar dados do administrador (sem senha) e token
    res.json({
      success: true,
      message: 'Login realizado com sucesso',
      token,
      admin: {
        id: admin.id,
        username: admin.username,
        role: admin.role
      }
    });

  } catch (error) {
    console.error('Erro no login:', error);
    res.status(500).json({
      error: 'Erro interno do servidor',
      code: 'INTERNAL_ERROR'
    });
  }
});

// POST /api/auth/logout - Fazer logout (opcional - token será invalidado no frontend)
router.post('/logout', authenticateToken, (req, res) => {
  res.json({
    success: true,
    message: 'Logout realizado com sucesso'
  });
});

// GET /api/auth/me - Verificar token atual
router.get('/me', authenticateToken, (req, res) => {
  res.json({
    success: true,
    admin: req.admin
  });
});

// POST /api/auth/change-password - Alterar senha (futuro)
router.post('/change-password', authenticateToken, async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;

    if (!currentPassword || !newPassword) {
      return res.status(400).json({
        error: 'Senha atual e nova senha são obrigatórias',
        code: 'MISSING_PASSWORDS'
      });
    }

    if (newPassword.length < 6) {
      return res.status(400).json({
        error: 'Nova senha deve ter pelo menos 6 caracteres',
        code: 'WEAK_PASSWORD'
      });
    }

    // Buscar senha atual do administrador
    const result = await query(
      'SELECT password_hash FROM admin_users WHERE id = $1',
      [req.admin.id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: 'Administrador não encontrado',
        code: 'ADMIN_NOT_FOUND'
      });
    }

    // Verificar senha atual
    const isValidCurrentPassword = await verifyPassword(currentPassword, result.rows[0].password_hash);
    
    if (!isValidCurrentPassword) {
      return res.status(401).json({
        error: 'Senha atual incorreta',
        code: 'INVALID_CURRENT_PASSWORD'
      });
    }

    // Hash da nova senha
    const newPasswordHash = await hashPassword(newPassword);

    // Atualizar senha no banco
    await query(
      'UPDATE admin_users SET password_hash = $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2',
      [newPasswordHash, req.admin.id]
    );

    res.json({
      success: true,
      message: 'Senha alterada com sucesso'
    });

  } catch (error) {
    console.error('Erro ao alterar senha:', error);
    res.status(500).json({
      error: 'Erro interno do servidor',
      code: 'INTERNAL_ERROR'
    });
  }
});

module.exports = router;
