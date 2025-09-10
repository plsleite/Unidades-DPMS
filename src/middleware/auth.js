const jwt = require('jsonwebtoken');
const { query } = require('../database');
const config = require('../config');

// Middleware para verificar token JWT
const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

  if (!token) {
    return res.status(401).json({ 
      error: 'Token de acesso necessário',
      code: 'NO_TOKEN' 
    });
  }

  try {
    // Verificar e decodificar o token
    const decoded = jwt.verify(token, config.jwt.secret);
    
    // Buscar administrador no banco
    const result = await query(
      'SELECT id, username, role FROM admin_users WHERE id = $1',
      [decoded.userId]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ 
        error: 'Token inválido ou administrador inativo',
        code: 'INVALID_TOKEN' 
      });
    }

    // Adicionar dados do administrador à requisição
    req.admin = result.rows[0];
    next();

  } catch (error) {
    console.error('Erro na autenticação:', error.message);
    
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ 
        error: 'Token expirado',
        code: 'TOKEN_EXPIRED' 
      });
    }
    
    return res.status(403).json({ 
      error: 'Token inválido',
      code: 'INVALID_TOKEN' 
    });
  }
};

// Middleware para verificar se é administrador (opcional - para futuras funcionalidades)
const requireAdmin = (req, res, next) => {
  if (!req.admin) {
    return res.status(403).json({ 
      error: 'Acesso negado - administrador necessário',
      code: 'ADMIN_REQUIRED' 
    });
  }
  next();
};

// Função para gerar token JWT
const generateToken = (adminId) => {
  return jwt.sign(
    { userId: adminId },
    config.jwt.secret,
    { expiresIn: '24h' } // Token válido por 24 horas
  );
};

// Função para verificar senha
const verifyPassword = async (plainPassword, hashedPassword) => {
  const bcrypt = require('bcrypt');
  return await bcrypt.compare(plainPassword, hashedPassword);
};

// Função para hash da senha
const hashPassword = async (plainPassword) => {
  const bcrypt = require('bcrypt');
  const saltRounds = 10;
  return await bcrypt.hash(plainPassword, saltRounds);
};

module.exports = {
  authenticateToken,
  requireAdmin,
  generateToken,
  verifyPassword,
  hashPassword
};
