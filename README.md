# Sistema de Unidades - Defensoria Pública MS

Sistema web para gerenciamento das unidades e defensorias da Defensoria Pública de Mato Grosso do Sul.

## 🚀 Funcionalidades

- **Visualização de Unidades**: Lista todas as 65 unidades da Defensoria Pública
- **Gestão de Defensorias**: Visualização das 249 defensorias distribuídas pelas unidades
- **Área Administrativa**: Interface para administradores gerenciarem os dados
- **Filtros e Busca**: Sistema de filtros por regional e busca por nome
- **Responsivo**: Interface adaptada para desktop e mobile

## 📁 Estrutura do Projeto

```
├── scripts/                    # Scripts e documentação
│   ├── sql/                   # Scripts SQL organizados
│   │   ├── README.md         # Documentação dos scripts
│   │   ├── limpar-banco.sql  # Script de limpeza
│   │   ├── insert-*.sql      # Scripts de inserção de dados
│   │   └── setup-*.sql       # Scripts de configuração
│   └── INSTRUCOES-INSERCAO-COMPLETA.md
├── routes/                    # Rotas da API
├── middleware/                # Middlewares de autenticação
├── index.html                # Página principal
├── script.js                 # JavaScript do frontend
├── styles.css                # Estilos CSS
├── server.js                 # Servidor Node.js
├── database.js               # Configuração do banco
└── config.js                 # Configurações gerais
```

## 🛠️ Tecnologias Utilizadas

- **Backend**: Node.js + Express
- **Banco de Dados**: PostgreSQL
- **Frontend**: HTML5 + CSS3 + JavaScript Vanilla
- **Autenticação**: JWT (JSON Web Tokens)

## 📊 Dados do Sistema

- **13 Regionais** da Defensoria Pública
- **65 Unidades** em todo o estado de MS
- **249 Defensorias** distribuídas pelas unidades

## 🚀 Como Executar

1. **Instalar dependências**:
   ```bash
   npm install
   ```

2. **Configurar banco de dados**:
   - Executar scripts em `scripts/sql/` no PostgreSQL
   - Verificar configurações em `config.js`

3. **Iniciar servidor**:
   ```bash
   npm start
   ```

4. **Acessar sistema**:
   - Frontend: http://localhost:3000
   - API: http://localhost:3000/api/test

## 🔐 Acesso Administrativo

- **Usuário**: admin
- **Senha**: admin123

## 📝 Scripts SQL

Todos os scripts SQL estão organizados na pasta `scripts/sql/` com documentação completa. Consulte o README específico para mais detalhes.

## 🎯 Status do Projeto

✅ **Concluído**: Sistema funcional com todos os dados inseridos
✅ **Testado**: Todas as funcionalidades testadas e funcionando
✅ **Organizado**: Código e scripts bem estruturados
