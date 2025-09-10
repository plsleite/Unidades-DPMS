# 🏛️ Sistema de Unidades - Defensoria Pública MS

Sistema web para gerenciamento das unidades e defensorias da Defensoria Pública de Mato Grosso do Sul.

## 🚀 Funcionalidades

### **🔍 Área Pública**
- **Visualização de Unidades**: Lista todas as 65 unidades da Defensoria Pública
- **Busca Inteligente**: Pesquisa por unidade, órgão, defensor titular ou substituto
- **Filtros Avançados**: 
  - Todas as defensorias
  - Defensorias vagas
  - Titulares afastados
  - Filtro por regional (13 regionais disponíveis)
- **Interface Colapsável**: Expansão/colapso de unidades para melhor navegação
- **Responsivo**: Interface adaptada para desktop e mobile

### **🔧 Área Administrativa**
- **Dashboard Executivo**: 
  - Estatísticas gerais (total de unidades, defensorias, vagas, afastamentos)
  - Indicadores por regional
  - Tabelas de defensorias com problemas
  - Gráficos e análises detalhadas
- **Gestão de Regionais**: 
  - Visualização e edição das 13 regionais
  - Criação de novas regionais
  - Busca e filtros
- **Gestão de Unidades**: 
  - Visualização e edição das 65 unidades
  - Criação de novas unidades
  - Gestão de coordenadores e supervisores
  - Busca e filtros
- **Gestão de Defensorias**: 
  - Visualização e edição das 249 defensorias
  - Criação de novas defensorias
  - Gestão de titulares e substitutos
  - Controle de status (vaga, afastado)
  - Busca e filtros
- **Sistema de Autenticação**: Login seguro com JWT

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

## 🎯 Funcionalidades Detalhadas

### **🔍 Sistema de Busca e Filtros**
- **Busca Global**: Pesquisa em tempo real por qualquer termo
- **Filtros Específicos**: 
  - Defensorias vagas (46 atualmente)
  - Titulares afastados (20 atualmente)
  - Filtro por regional com chips interativos
- **Busca Inteligente**: Normalização de texto com acentos
- **Interface Responsiva**: Funciona perfeitamente em mobile

### **📊 Dashboard Administrativo**
- **Métricas em Tempo Real**:
  - Total de unidades e defensorias
  - Contadores de vagas e afastamentos
  - Estatísticas por regional
- **Tabelas Interativas**:
  - Lista de defensorias vagas
  - Lista de titulares afastados
  - Dados por regional com percentuais
- **Navegação Intuitiva**: Abas organizadas por funcionalidade

### **🏢 Gestão Completa de Dados**
- **CRUD Completo**: Criar, visualizar, editar e deletar registros
- **Validação de Dados**: Campos obrigatórios e validações específicas
- **Busca e Filtros**: Em todas as seções administrativas
- **Interface Modal**: Formulários organizados e intuitivos
- **Feedback Visual**: Confirmações e mensagens de erro claras

### **🔐 Segurança e Autenticação**
- **JWT Tokens**: Autenticação segura e stateless
- **Controle de Acesso**: Área administrativa protegida
- **Sessão Persistente**: Login mantido entre recarregamentos
- **Logout Seguro**: Limpeza completa de dados sensíveis

## 💼 Casos de Uso

### **👥 Para Usuários Públicos**
- **Consulta de Defensorias**: Encontrar defensorias por localização ou especialidade
- **Busca de Defensores**: Localizar defensores titulares ou substitutos
- **Verificação de Status**: Verificar se defensorias estão vagas ou com titulares afastados
- **Filtros por Regional**: Navegar por regionais específicas

### **👨‍💼 Para Administradores**
- **Monitoramento**: Acompanhar estatísticas em tempo real
- **Gestão de Recursos**: Gerenciar regionais, unidades e defensorias
- **Controle de Vagas**: Identificar e gerenciar defensorias vagas
- **Gestão de Pessoal**: Controlar titulares e substitutos
- **Relatórios**: Gerar relatórios e análises detalhadas

### **🏛️ Para a Instituição**
- **Transparência**: Interface pública para consulta de dados
- **Eficiência**: Sistema automatizado de gestão
- **Controle**: Visão completa da estrutura organizacional
- **Tomada de Decisão**: Dados precisos para planejamento estratégico

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

### **✅ Funcionalidades Implementadas**
- **Sistema Público**: Busca, filtros e visualização de dados
- **Área Administrativa**: Dashboard completo com 4 seções de gestão
- **Autenticação**: Sistema de login seguro com JWT
- **API RESTful**: Endpoints completos para todas as operações
- **Interface Responsiva**: Funciona perfeitamente em desktop e mobile
- **Banco de Dados**: Estrutura completa com 249 defensorias

### **✅ Qualidade e Organização**
- **Código Limpo**: Estrutura seguindo melhores práticas
- **Documentação Completa**: 4 guias especializados
- **Testes**: Sistema testado e validado
- **Reestruturação**: Organização profissional do projeto
- **Versionamento**: Controle de versão com Git e GitHub

### **🚀 Próximas Melhorias**
- **Testes Automatizados**: Implementação de testes unitários e de integração
- **Logs Avançados**: Sistema de logging estruturado
- **Cache**: Implementação de cache para melhor performance
- **Docker**: Containerização para deploy
- **CI/CD**: Automação de deploy e testes

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
