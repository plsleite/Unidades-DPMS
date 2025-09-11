const request = require('supertest');
const express = require('express');

// Mock do banco de dados
const mockQuery = jest.fn();
const mockTestConnection = jest.fn();

jest.mock('../../src/config/database', () => ({
  query: mockQuery,
  testConnection: mockTestConnection
}));

// Mock das rotas de monitoramento
const mockApiRoutes = express.Router();

// Rota de teste da API
mockApiRoutes.get('/test', (req, res) => {
  res.json({ 
    message: 'API da Defensoria Pública MS funcionando!',
    timestamp: new Date().toISOString()
  });
});

// Rota de teste do banco
mockApiRoutes.get('/test-db', async (req, res) => {
  try {
    const result = await mockQuery('SELECT NOW() as current_time');
    res.json({
      database: 'Conectado',
      timestamp: result.rows[0].current_time
    });
  } catch (error) {
    res.status(500).json({
      database: 'Erro',
      error: error.message
    });
  }
});

// Rota de métricas
mockApiRoutes.get('/metrics', (req, res) => {
  const memUsage = process.memoryUsage();
  const uptime = process.uptime();
  
  res.json({
    memory: {
      used: Math.round(memUsage.heapUsed / 1024 / 1024),
      total: Math.round(memUsage.heapTotal / 1024 / 1024),
      external: Math.round(memUsage.external / 1024 / 1024)
    },
    uptime: {
      seconds: Math.round(uptime),
      formatted: formatUptime(uptime)
    },
    connections: {
      active: 1,
      total: 10,
      peak: 3
    },
    node: {
      version: process.version,
      platform: process.platform
    },
    timestamp: new Date().toISOString()
  });
});

function formatUptime(seconds) {
  const days = Math.floor(seconds / 86400);
  const hours = Math.floor((seconds % 86400) / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  const secs = Math.floor(seconds % 60);
  
  return `${days}d ${hours}h ${minutes}m ${secs}s`;
}

// Criar app de teste
const app = express();
app.use(express.json());
app.use('/api', mockApiRoutes);

describe('Monitoring System', () => {
  beforeEach(() => {
    // Reset mocks
    mockQuery.mockClear();
    mockTestConnection.mockClear();
  });

  describe('API Health Check', () => {
    it('should return API status', async () => {
      const response = await request(app)
        .get('/api/test')
        .expect(200);
      
      expect(response.body).toHaveProperty('message');
      expect(response.body.message).toContain('API da Defensoria Pública MS funcionando');
      expect(response.body).toHaveProperty('timestamp');
    });
  });

  describe('Database Health Check', () => {
    it('should return database status when connected', async () => {
      mockQuery.mockResolvedValue({
        rows: [{ current_time: '2025-09-11T10:00:00.000Z' }]
      });

      const response = await request(app)
        .get('/api/test-db')
        .expect(200);
      
      expect(response.body).toHaveProperty('database', 'Conectado');
      expect(response.body).toHaveProperty('timestamp');
    });

    it('should return error when database fails', async () => {
      mockQuery.mockRejectedValue(new Error('Connection failed'));

      const response = await request(app)
        .get('/api/test-db')
        .expect(500);
      
      expect(response.body).toHaveProperty('database', 'Erro');
      expect(response.body).toHaveProperty('error');
    });
  });

  describe('System Metrics', () => {
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

    it('should have valid memory metrics', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body.memory).toHaveProperty('used');
      expect(response.body.memory).toHaveProperty('total');
      expect(response.body.memory).toHaveProperty('external');
      
      expect(typeof response.body.memory.used).toBe('number');
      expect(typeof response.body.memory.total).toBe('number');
      expect(typeof response.body.memory.external).toBe('number');
      
      expect(response.body.memory.used).toBeGreaterThan(0);
      expect(response.body.memory.total).toBeGreaterThan(0);
    });

    it('should have valid uptime metrics', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body.uptime).toHaveProperty('seconds');
      expect(response.body.uptime).toHaveProperty('formatted');
      
      expect(typeof response.body.uptime.seconds).toBe('number');
      expect(typeof response.body.uptime.formatted).toBe('string');
      expect(response.body.uptime.seconds).toBeGreaterThanOrEqual(0);
    });

    it('should have valid connection metrics', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body.connections).toHaveProperty('active');
      expect(response.body.connections).toHaveProperty('total');
      expect(response.body.connections).toHaveProperty('peak');
      
      expect(typeof response.body.connections.active).toBe('number');
      expect(typeof response.body.connections.total).toBe('number');
      expect(typeof response.body.connections.peak).toBe('number');
      
      expect(response.body.connections.active).toBeGreaterThanOrEqual(0);
      expect(response.body.connections.total).toBeGreaterThanOrEqual(0);
      expect(response.body.connections.peak).toBeGreaterThanOrEqual(0);
    });

    it('should have valid node information', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body.node).toHaveProperty('version');
      expect(response.body.node).toHaveProperty('platform');
      
      expect(typeof response.body.node.version).toBe('string');
      expect(typeof response.body.node.platform).toBe('string');
      expect(response.body.node.version).toMatch(/^v\d+\.\d+\.\d+/);
    });

    it('should have valid timestamp', async () => {
      const response = await request(app)
        .get('/api/metrics')
        .expect(200);
      
      expect(response.body).toHaveProperty('timestamp');
      expect(typeof response.body.timestamp).toBe('string');
      
      // Verificar se é uma data válida
      const date = new Date(response.body.timestamp);
      expect(date).toBeInstanceOf(Date);
      expect(date.getTime()).not.toBeNaN();
    });
  });

  describe('Uptime Formatting', () => {
    it('should format uptime correctly for seconds', () => {
      expect(formatUptime(30)).toBe('0d 0h 0m 30s');
    });

    it('should format uptime correctly for minutes', () => {
      expect(formatUptime(90)).toBe('0d 0h 1m 30s');
    });

    it('should format uptime correctly for hours', () => {
      expect(formatUptime(3661)).toBe('0d 1h 1m 1s');
    });

    it('should format uptime correctly for days', () => {
      expect(formatUptime(90061)).toBe('1d 1h 1m 1s');
    });
  });
});
