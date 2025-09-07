-- Criar tabela de usuários administradores
CREATE TABLE public.admin_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir usuário administrador padrão
-- Usuário: admin
-- Senha: admin123
-- Hash gerado com bcrypt para 'admin123'
INSERT INTO public.admin_users (username, password_hash, role) 
VALUES (
    'admin', 
    '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 
    'admin'
);

-- Verificar se foi inserido corretamente
SELECT * FROM public.admin_users;
