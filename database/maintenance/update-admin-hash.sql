-- Atualizar hash da senha do administrador
UPDATE public.admin_users 
SET password_hash = '$2b$10$30IqSpIypCxN.nkBM2zjs.s9TwySZzDBb8u0IM6BrdaywZS777ufq'
WHERE username = 'admin';

-- Verificar se foi atualizado
SELECT username, password_hash FROM public.admin_users WHERE username = 'admin';
