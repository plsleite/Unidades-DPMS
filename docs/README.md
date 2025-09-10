# 🏛️ Sistema de Unidades - Defensoria Pública MS

Sistema web para gerenciamento das unidades e defensorias da Defensoria Pública de Mato Grosso do Sul.

## 🚀 Funcionalidades

- **Visualização de Unidades**: Lista todas as 65 unidades da Defensoria Pública
- **Gestão de Defensorias**: Visualização das 249 defensorias distribuídas pelas unidades
- **Área Administrativa**: Interface para administradores gerenciarem os dados
- **Filtros e Busca**: Sistema de filtros por regional e busca por nome
- **Dashboard Estatístico**: Indicadores e relatórios administrativos
- **Responsivo**: Interface adaptada para desktop e mobile

## 📁 Estrutura do Projeto

```
defensoria-ms-unidades/
├── 📁 public/                     # Frontend estático
│   ├── index.html
│   ├── script.js
│   ├── styles.css
│   └── assets/                    # Imagens, ícones, etc.
│
├── 📁 src/                        # Código fonte do backend
│   ├── 📁 config/                 # Configurações
│   │   ├── database.js
│   │   └── index.js
│   ├── 📁 controllers/            # Lógica de negócio
│   ├── 📁 middleware/             # Middlewares
│   │   └── auth.js
│   ├── 📁 routes/                 # Rotas da API
│   │   ├── api.js
│   │   └── auth.js
│   └── server.js                  # Servidor principal
│
├── 📁 database/                   # Scripts e documentação do banco
│   ├── 📁 migrations/             # Scripts de migração
│   ├── 📁 seeds/                  # Dados iniciais
│   ├── 📁 maintenance/            # Scripts de manutenção
│   └── README.md                  # Documentação do banco
│
├── 📁 docs/                       # Documentação do projeto
│   ├── README.md                  # Este arquivo
│   ├── INSTALACAO.md              # Guia de instalação
│   ├── CONFIGURACAO.md            # Guia de configuração
│   ├── API.md                     # Documentação da API
│   └── DASHBOARD-SUGESTOES.md     # Sugestões de melhorias
│
├── 📁 tests/                      # Testes (futuro)
├── 📁 logs/                       # Logs do sistema
├── .env.example                   # Exemplo de variáveis de ambiente
├── .gitignore
├── package.json
└── package-lock.json
```

## 🛠️ Tecnologias Utilizadas

- **Backend**: Node.js + Express
- **Banco de Dados**: PostgreSQL
- **Frontend**: HTML5 + CSS3 + JavaScript Vanilla
- **Autenticação**: JWT (JSON Web Tokens)
- **Documentação**: Markdown

## 📊 Dados do Sistema

- **13 Regionais** da Defensoria Pública
- **65 Unidades** em todo o estado de MS
- **249 Defensorias** distribuídas pelas unidades

## 🚀 Início Rápido

### **1. Instalação**
```bash
# Clonar repositório
git clone <url-do-repositorio>
cd defensoria-ms-unidades

# Instalar dependências
npm install
```

### **2. Configuração**
```bash
# Copiar arquivo de configuração
cp .env.example .env

# Editar configurações
nano .env
```

### **3. Banco de Dados**
```bash
# Executar scripts de migração
psql -d defensoria_ms -f database/migrations/setup-coordenacoes.sql
psql -d defensoria_ms -f database/migrations/setup-admin.sql

# Inserir dados iniciais
psql -d defensoria_ms -f database/seeds/insert-completo.sql
psql -d defensoria_ms -f database/seeds/insert-defensorias-parte1.sql
# ... (executar todos os seeds)
```

### **4. Executar**
```bash
npm start
```

### **5. Acessar**
- **Frontend**: http://localhost:3000
- **API**: http://localhost:3000/api/test

## 🔐 Acesso Administrativo

- **Usuário**: admin
- **Senha**: admin123

## 📚 Documentação

- **[Guia de Instalação](docs/INSTALACAO.md)** - Instruções detalhadas de instalação
- **[Guia de Configuração](docs/CONFIGURACAO.md)** - Configurações do sistema
- **[Documentação da API](docs/API.md)** - Endpoints e exemplos de uso
- **[Sugestões de Dashboard](docs/DASHBOARD-SUGESTOES.md)** - Melhorias futuras

## 🗄️ Banco de Dados

Todos os scripts SQL estão organizados na pasta `database/`:
- **migrations/**: Scripts de criação e alteração de estrutura
- **seeds/**: Dados iniciais do sistema
- **maintenance/**: Scripts de limpeza e manutenção

Consulte o [README do banco](database/README.md) para mais detalhes.

## 🎯 Status do Projeto

✅ **Concluído**: Sistema funcional com todos os dados inseridos
✅ **Testado**: Todas as funcionalidades testadas e funcionando
✅ **Organizado**: Código e scripts bem estruturados
✅ **Documentado**: Documentação completa e organizada
✅ **Reestruturado**: Seguindo melhores práticas de desenvolvimento

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📞 Suporte

Para problemas ou dúvidas:
1. Consulte a documentação
2. Verifique os logs do sistema
3. Abra uma issue no repositório
4. Entre em contato com a equipe de desenvolvimento
