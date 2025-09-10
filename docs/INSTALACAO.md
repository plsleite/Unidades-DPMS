# 🚀 Guia de Instalação - Sistema de Unidades DPMS

## 📋 Pré-requisitos

- **Node.js** (versão 14 ou superior)
- **PostgreSQL** (versão 12 ou superior)
- **Git** (para clonagem do repositório)

## 🔧 Instalação

### 1. **Clonar o Repositório**
```bash
git clone <url-do-repositorio>
cd defensoria-ms-unidades
```

### 2. **Instalar Dependências**
```bash
npm install
```

### 3. **Configurar Banco de Dados**

#### 3.1. Criar Banco de Dados
```sql
-- Conectar ao PostgreSQL como superusuário
CREATE DATABASE defensoria_ms;
```

#### 3.2. Executar Scripts de Migração
```bash
# Executar scripts na ordem:
psql -d defensoria_ms -f database/migrations/setup-coordenacoes.sql
psql -d defensoria_ms -f database/migrations/setup-admin.sql
psql -d defensoria_ms -f database/migrations/add-data-vacancia-field.sql
psql -d defensoria_ms -f database/migrations/add-portaria-vacancia-field.sql
```

#### 3.3. Inserir Dados Iniciais
```bash
# Executar scripts de seeds na ordem:
psql -d defensoria_ms -f database/seeds/insert-completo.sql
psql -d defensoria_ms -f database/seeds/insert-defensorias-parte1.sql
psql -d defensoria_ms -f database/seeds/insert-defensorias-parte2.sql
psql -d defensoria_ms -f database/seeds/insert-defensorias-parte3.sql
psql -d defensoria_ms -f database/seeds/insert-defensorias-parte4.sql
```

### 4. **Configurar Variáveis de Ambiente**
```bash
# Copiar arquivo de exemplo
cp .env.example .env

# Editar configurações
nano .env
```

### 5. **Iniciar o Servidor**
```bash
npm start
```

### 6. **Acessar o Sistema**
- **Frontend**: http://localhost:3000
- **API**: http://localhost:3000/api/test

## 🔐 Acesso Administrativo

- **Usuário**: admin
- **Senha**: admin123

## 🗂️ Estrutura de Scripts SQL

### **Migrations** (`database/migrations/`)
- Scripts de criação e alteração de estrutura
- Executar na ordem de numeração

### **Seeds** (`database/seeds/`)
- Dados iniciais do sistema
- Executar após migrations

### **Maintenance** (`database/maintenance/`)
- Scripts de limpeza e manutenção
- Usar com cuidado

## ⚠️ Troubleshooting

### **Erro de Conexão com Banco**
1. Verificar se PostgreSQL está rodando
2. Verificar credenciais no `.env`
3. Verificar se o banco `defensoria_ms` existe

### **Erro de Dependências**
```bash
# Limpar cache e reinstalar
rm -rf node_modules package-lock.json
npm install
```

### **Erro de Porta em Uso**
```bash
# Encontrar processo usando porta 3000
lsof -ti:3000

# Matar processo
lsof -ti:3000 | xargs kill -9
```

## 📊 Dados do Sistema

Após instalação completa, o sistema terá:
- **13 Regionais** da Defensoria Pública
- **65 Unidades** em todo o estado de MS
- **249 Defensorias** distribuídas pelas unidades

## 🔄 Scripts de Manutenção

### **Limpar Banco de Dados**
```bash
psql -d defensoria_ms -f database/maintenance/limpar-banco.sql
```

### **Atualizar Senha do Admin**
```bash
psql -d defensoria_ms -f database/maintenance/update-admin-hash.sql
```

### **Atualizar Status de Vagas**
```bash
psql -d defensoria_ms -f database/maintenance/update-vacancias-defensorias.sql
```

## 📞 Suporte

Para problemas ou dúvidas:
1. Verificar logs do servidor
2. Verificar logs do PostgreSQL
3. Consultar documentação da API
4. Abrir issue no repositório
