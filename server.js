const express = require('express');
const cors = require('cors');
const path = require('path');
const { testConnection } = require('./database');
const config = require('./config');
const apiRoutes = require('./routes/api');
const authRoutes = require('./routes/auth');

// Criar aplicação Express
const app = express();

// Middlewares
app.use(cors()); // Permitir requisições do frontend
app.use(express.json()); // Parse JSON
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded

// Servir arquivos estáticos (frontend)
app.use(express.static(path.join(__dirname)));

// Rota principal - servir o index.html
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
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

// Iniciar servidor
const PORT = config.server.port;
app.listen(PORT, () => {
  console.log('🚀 Servidor rodando na porta', PORT);
  console.log('🌐 Acesse: http://localhost:' + PORT);
  console.log('📊 API: http://localhost:' + PORT + '/api/test');
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
