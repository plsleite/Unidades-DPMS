# ⚙️ Guia de Configuração - Sistema de Unidades DPMS

## 🔧 Configuração do Banco de Dados

### **Variáveis de Ambiente (.env)**
```env
# Banco de Dados
DB_HOST=localhost
DB_PORT=5432
DB_NAME=defensoria_ms
DB_USER=postgres
DB_PASSWORD=sua_senha_aqui

# Servidor
PORT=3000
NODE_ENV=development

# JWT (Autenticação)
JWT_SECRET=seu_jwt_secret_aqui

# Logs
LOG_LEVEL=info
```

### **Configuração de Produção**
```env
# Banco de Dados (Produção)
DB_HOST=seu_servidor_producao
DB_PORT=5432
DB_NAME=defensoria_ms_prod
DB_USER=usuario_producao
DB_PASSWORD=senha_segura_producao

# Servidor (Produção)
PORT=3000
NODE_ENV=production

# JWT (Produção) - Use uma chave forte e única
JWT_SECRET=chave_jwt_muito_segura_para_producao

# Logs (Produção)
LOG_LEVEL=warn
```

## 🗄️ Estrutura do Banco de Dados

### **Tabelas Principais**
- `regionais` - Regionais da Defensoria Pública
- `unidades` - Unidades físicas
- `defensorias` - Defensorias (órgãos)
- `usuarios` - Usuários do sistema
- `coordenacoes` - Coordenações administrativas

### **Relacionamentos**
- Regional → Unidades (1:N)
- Unidade → Defensorias (1:N)
- Usuário → Coordenação (N:1)

## 🔐 Configuração de Segurança

### **Senhas**
- Use senhas fortes para o banco de dados
- Altere a senha padrão do admin
- Use JWT secrets únicos por ambiente

### **CORS**
```javascript
// Configuração CORS no server.js
app.use(cors({
  origin: ['http://localhost:3000', 'https://seu-dominio.com'],
  credentials: true
}));
```

### **Rate Limiting** (Recomendado)
```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 100 // máximo 100 requests por IP
});

app.use('/api', limiter);
```

## 📊 Configuração de Logs

### **Estrutura de Logs**
```
logs/
├── access.log      # Logs de acesso
├── error.log       # Logs de erro
├── app.log         # Logs da aplicação
└── database.log    # Logs do banco
```

### **Níveis de Log**
- `error` - Apenas erros
- `warn` - Avisos e erros
- `info` - Informações gerais
- `debug` - Informações detalhadas

## 🚀 Configuração de Performance

### **Pool de Conexões**
```javascript
// src/config/database.js
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20,                    // Máximo de conexões
  idleTimeoutMillis: 30000,   // Timeout de conexão ociosa
  connectionTimeoutMillis: 2000, // Timeout de conexão
});
```

### **Cache (Recomendado)**
```javascript
// Implementar cache Redis para consultas frequentes
const redis = require('redis');
const client = redis.createClient();

// Cache de consultas por 5 minutos
const cache = (duration) => {
  return (req, res, next) => {
    const key = req.originalUrl;
    client.get(key, (err, result) => {
      if (result) {
        res.json(JSON.parse(result));
      } else {
        next();
      }
    });
  };
};
```

## 🔄 Configuração de Backup

### **Backup Automático do Banco**
```bash
#!/bin/bash
# backup.sh
DATE=$(date +%Y%m%d_%H%M%S)
pg_dump defensoria_ms > backup_${DATE}.sql
```

### **Cron Job para Backup Diário**
```bash
# Adicionar ao crontab
0 2 * * * /caminho/para/backup.sh
```

## 📱 Configuração de Frontend

### **Variáveis de Ambiente (Frontend)**
```javascript
// public/script.js
const API_BASE_URL = window.location.origin + '/api';
const APP_VERSION = '1.0.0';
const DEBUG_MODE = false;
```

### **Configuração de Build (Futuro)**
```json
// package.json
{
  "scripts": {
    "build": "webpack --mode production",
    "dev": "webpack serve --mode development"
  }
}
```

## 🌐 Configuração de Deploy

### **Docker (Recomendado)**
```dockerfile
# Dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### **Docker Compose**
```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
  
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: defensoria_ms
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: senha_segura
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## 🔍 Monitoramento

### **Health Check**
```javascript
// Endpoint de saúde da aplicação
app.get('/health', async (req, res) => {
  try {
    await testConnection();
    res.json({ 
      status: 'healthy', 
      timestamp: new Date().toISOString(),
      uptime: process.uptime()
    });
  } catch (error) {
    res.status(500).json({ 
      status: 'unhealthy', 
      error: error.message 
    });
  }
});
```

### **Métricas de Performance**
- Tempo de resposta da API
- Uso de memória
- Conexões ativas do banco
- Número de requests por minuto

## ⚠️ Configurações Importantes

### **Limites de Upload**
```javascript
// Limitar tamanho de uploads
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));
```

### **Timeouts**
```javascript
// Configurar timeouts
server.timeout = 30000; // 30 segundos
server.keepAliveTimeout = 5000; // 5 segundos
```

### **Compressão**
```javascript
const compression = require('compression');
app.use(compression());
```

## 📋 Checklist de Configuração

- [ ] Banco de dados criado e configurado
- [ ] Variáveis de ambiente definidas
- [ ] Scripts SQL executados
- [ ] Senhas alteradas (admin e banco)
- [ ] CORS configurado
- [ ] Logs configurados
- [ ] Backup configurado
- [ ] Monitoramento ativo
- [ ] Testes de conectividade
- [ ] Documentação atualizada
