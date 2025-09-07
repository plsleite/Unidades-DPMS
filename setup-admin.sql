-- Script para criar tabela de administradores
-- Execute este script no pgAdmin para criar a estrutura de autenticação

-- Criar tabela de administradores
CREATE TABLE IF NOT EXISTS administradores (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    ativo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir administrador padrão (senha: admin123)
-- IMPORTANTE: Altere a senha após o primeiro login!
INSERT INTO administradores (username, password_hash, nome, email) 
VALUES (
    'admin', 
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', -- senha: admin123
    'Administrador do Sistema',
    'admin@defensoria.ms.def.br'
) ON CONFLICT (username) DO NOTHING;

-- Criar índices para performance
CREATE INDEX IF NOT EXISTS idx_administradores_username ON administradores(username);
CREATE INDEX IF NOT EXISTS idx_administradores_ativo ON administradores(ativo);

-- Comentários para documentação
COMMENT ON TABLE administradores IS 'Tabela de administradores do sistema';
COMMENT ON COLUMN administradores.password_hash IS 'Hash bcrypt da senha do administrador';
COMMENT ON COLUMN administradores.ativo IS 'Indica se o administrador está ativo no sistema';
