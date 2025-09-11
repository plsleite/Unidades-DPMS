const express = require('express');
const cors = require('cors');
const path = require('path');
const { testConnection } = require('./config/database');
const config = require('./config');
const apiRoutes = require('./routes/api');
const authRoutes = require('./routes/auth');
const logger = require('./utils/logger');
const { requestLogger, errorLogger } = require('./middleware/logging');

// Criar aplicação Express
const app = express();

// Contador de conexões ativas
let activeConnections = 0;
let totalConnections = 0;
let peakConnections = 0;

// Middleware para contar conexões
app.use((req, res, next) => {
  activeConnections++;
  totalConnections++;
  
  if (activeConnections > peakConnections) {
    peakConnections = activeConnections;
  }
  
  // Expor contadores para as rotas
  app.locals.connections = {
    active: activeConnections,
    total: totalConnections,
    peak: peakConnections
  };
  
  res.on('finish', () => {
    activeConnections--;
    // Atualizar contadores após finalizar
    app.locals.connections = {
      active: activeConnections,
      total: totalConnections,
      peak: peakConnections
    };
  });
  
  next();
});

// Middlewares
app.use(cors()); // Permitir requisições do frontend
app.use(express.json()); // Parse JSON
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded
app.use(requestLogger); // Logging de requisições

// Servir arquivos estáticos (frontend)
app.use(express.static(path.join(__dirname, '../public')));

// Rota principal - servir o index.html
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../public/index.html'));
});

// Rota de monitoramento
app.get('/monitoring', (req, res) => {
  res.sendFile(path.join(__dirname, '../public/monitoring.html'));
});

// Rota de teste da API
app.get('/api/test', (req, res) => {
  res.json({ 
    message: 'API da Defensoria Pública MS funcionando!', 
    timestamp: new Date().toISOString() 
  });
});

// Rota de teste do banco
app.get('/api/test-db', async (req, res) => {
  try {
    const isConnected = await testConnection();
    res.json({ 
      database: isConnected ? 'Conectado' : 'Desconectado',
      timestamp: new Date().toISOString() 
    });
  } catch (error) {
    res.status(500).json({ 
      error: 'Erro ao conectar com o banco',
      message: error.message 
    });
  }
});

// Usar rotas da API
app.use('/api', apiRoutes);

// Usar rotas de autenticação
app.use('/api/auth', authRoutes);

// Middleware de tratamento de erros
app.use(errorLogger);

// Iniciar servidor
const PORT = config.server.port;
app.listen(PORT, async () => {
  logger.info(`🚀 Servidor rodando na porta ${PORT}`);
  logger.info(`🌐 Acesse: http://localhost:${PORT}`);
  logger.info(`📊 API: http://localhost:${PORT}/api/test`);
  await testConnection();
});

// Tratamento de erros não capturados
process.on('unhandledRejection', (err) => {
  console.error('❌ Erro não tratado:', err);
  process.exit(1);
});

process.on('uncaughtException', (err) => {
  console.error('❌ Exceção não capturada:', err);
  process.exit(1);
});
