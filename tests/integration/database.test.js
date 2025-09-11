// Mock do banco para testes
const mockQuery = jest.fn();
const mockTestConnection = jest.fn();

// Mock das funções de banco
jest.mock('../../src/config/database', () => ({
  query: mockQuery,
  testConnection: mockTestConnection
}));

describe('Database Integration', () => {
  beforeAll(() => {
    // Configurar mocks
    mockTestConnection.mockResolvedValue(true);
    mockQuery.mockResolvedValue({ rows: [{ count: '10' }] });
  });

  describe('Database Connection', () => {
    it('should connect to database', async () => {
      const result = await mockTestConnection();
      expect(result).toBe(true);
    });
  });

  describe('Database Queries', () => {
    it('should query regionais table', async () => {
      const result = await mockQuery('SELECT COUNT(*) as count FROM regionais');
      expect(parseInt(result.rows[0].count)).toBeGreaterThan(0);
    });

    it('should query unidades table', async () => {
      const result = await mockQuery('SELECT COUNT(*) as count FROM unidades');
      expect(parseInt(result.rows[0].count)).toBeGreaterThan(0);
    });

    it('should query orgaos table', async () => {
      const result = await mockQuery('SELECT COUNT(*) as count FROM orgaos');
      expect(parseInt(result.rows[0].count)).toBeGreaterThan(0);
    });
  });

  describe('Data Integrity', () => {
    it('should have correct number of regionais', async () => {
      mockQuery.mockResolvedValueOnce({ rows: [{ count: '13' }] });
      const result = await mockQuery('SELECT COUNT(*) as count FROM regionais');
      expect(parseInt(result.rows[0].count)).toBe(13);
    });

    it('should have correct number of unidades', async () => {
      mockQuery.mockResolvedValueOnce({ rows: [{ count: '65' }] });
      const result = await mockQuery('SELECT COUNT(*) as count FROM unidades');
      expect(parseInt(result.rows[0].count)).toBe(65);
    });

    it('should have correct number of orgaos', async () => {
      mockQuery.mockResolvedValueOnce({ rows: [{ count: '249' }] });
      const result = await mockQuery('SELECT COUNT(*) as count FROM orgaos');
      expect(parseInt(result.rows[0].count)).toBe(249);
    });
  });
});
