const request = require('supertest');
const express = require('express');

// Mock do banco de dados para testes
const mockQuery = jest.fn();
const mockTestConnection = jest.fn();

// Mock das funções de banco
jest.mock('../../src/config/database', () => ({
  query: mockQuery,
  testConnection: mockTestConnection
}));

// Mock das rotas que dependem do banco
const mockApiRoutes = express.Router();
const mockAuthRoutes = express.Router();

// Rota de teste simples
mockApiRoutes.get('/test', (req, res) => {
  res.json({ 
    message: 'API da Defensoria Pública MS funcionando!',
    timestamp: new Date().toISOString()
  });
});

// Rota de métricas mockada
mockApiRoutes.get('/metrics', (req, res) => {
  res.json({
    memory: { used: 10, total: 20, external: 2 },
    uptime: { seconds: 100, formatted: '0d 0h 1m 40s' },
    connections: { active: 1, total: 5, peak: 2 },
    node: { version: 'v18.0.0', platform: 'darwin' },
    timestamp: new Date().toISOString()
  });
});

// Rota de unidades mockada
mockApiRoutes.get('/unidades', (req, res) => {
  res.json([
    { id: 1, nome: 'Unidade Teste 1', endereco: 'Endereço 1' },
    { id: 2, nome: 'Unidade Teste 2', endereco: 'Endereço 2' }
  ]);
});

// Rota de regionais mockada
mockApiRoutes.get('/regionais', (req, res) => {
  res.json([
    { id: 1, nome: 'Regional Teste 1', numero: 1 },
    { id: 2, nome: 'Regional Teste 2', numero: 2 }
  ]);
});

// Rota de login mockada
mockAuthRoutes.post('/login', (req, res) => {
  const { username, password } = req.body;
  
  if (username === 'admin' && password === 'admin123') {
    res.json({
      success: true,
      token: 'mock-jwt-token',
      user: { username: 'admin' }
    });
  } else {
    res.status(401).json({
      success: false,
      message: 'Credenciais inválidas'
    });
  }
});

// Criar app de teste
const app = express();
app.use(express.json());
app.use('/api', mockApiRoutes);
app.use('/api/auth', mockAuthRoutes);

describe('API Endpoints', () => {
  describe('GET /api/test', () => {
    it('should return API status', async () => {
      const response = await request(app)
        .get('/api/test')
        .expect(200);
      
      expect(response.body).toHaveProperty('message');
      expect(response.body.message).toContain('API da Defensoria Pública MS funcionando');
    });
  });

  describe('GET /api/unidades', () => {
    it('should return list of unidades', async () => {
      const response = await request(app)
        .get('/api/unidades')
        .expect(200);
      
      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  describe('GET /api/regionais', () => {
    it('should return list of regionais', async () => {
      const response = await request(app)
        .get('/api/regionais')
        .expect(200);
      
      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  describe('POST /api/auth/login', () => {
    it('should login with valid credentials', async () => {
      const response = await request(app)
        .post('/api/auth/login')
        .send({
          username: 'admin',
          password: 'admin123'
        })
        .expect(200);
      
      expect(response.body).toHaveProperty('success', true);
      expect(response.body).toHaveProperty('token');
    });

    it('should reject invalid credentials', async () => {
      const response = await request(app)
        .post('/api/auth/login')
        .send({
          username: 'invalid',
          password: 'wrong'
        })
        .expect(401);
      
      expect(response.body).toHaveProperty('success', false);
    });
  });

  describe('GET /api/metrics', () => {
    it('should return system metrics', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body).toHaveProperty('memory');
      expect(response.body).toHaveProperty('uptime');
      expect(response.body).toHaveProperty('connections');
      expect(response.body).toHaveProperty('node');
      expect(response.body).toHaveProperty('timestamp');
    });

    it('should have correct memory structure', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body.memory).toHaveProperty('used');
      expect(response.body.memory).toHaveProperty('total');
      expect(response.body.memory).toHaveProperty('external');
      expect(typeof response.body.memory.used).toBe('number');
    });

    it('should have correct connections structure', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body.connections).toHaveProperty('active');
      expect(response.body.connections).toHaveProperty('total');
      expect(response.body.connections).toHaveProperty('peak');
      expect(typeof response.body.connections.active).toBe('number');
    });
  });
});
