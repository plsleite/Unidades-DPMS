const logger = require('../../src/utils/logger');
const fs = require('fs');
const path = require('path');

describe('Logger System', () => {
  const logDir = path.join(__dirname, '../../logs');
  const appLogPath = path.join(logDir, 'app.log');
  const errorLogPath = path.join(logDir, 'error.log');

  beforeEach(() => {
    // Limpar logs antes de cada teste
    if (fs.existsSync(appLogPath)) {
      fs.writeFileSync(appLogPath, '');
    }
    if (fs.existsSync(errorLogPath)) {
      fs.writeFileSync(errorLogPath, '');
    }
  });

  describe('Logger Creation', () => {
    it('should create logger instance', () => {
      expect(logger).toBeDefined();
      expect(typeof logger.info).toBe('function');
      expect(typeof logger.error).toBe('function');
      expect(typeof logger.warn).toBe('function');
      expect(typeof logger.debug).toBe('function');
    });

    it('should create log directory', () => {
      expect(fs.existsSync(logDir)).toBe(true);
    });
  });

  describe('Logging Functions', () => {
    it('should log info messages', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();
      
      logger.info('Test info message');
      
      expect(consoleSpy).toHaveBeenCalledWith('[INFO] Test info message', {});
      consoleSpy.mockRestore();
    });

    it('should log error messages', () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
      
      logger.error('Test error message');
      
      expect(consoleSpy).toHaveBeenCalledWith('[ERROR] Test error message', {});
      consoleSpy.mockRestore();
    });

    it('should log warning messages', () => {
      const consoleSpy = jest.spyOn(console, 'warn').mockImplementation();
      
      logger.warn('Test warning message');
      
      expect(consoleSpy).toHaveBeenCalledWith('[WARN] Test warning message', {});
      consoleSpy.mockRestore();
    });

    it('should log debug messages when LOG_LEVEL is debug', () => {
      const originalLogLevel = process.env.LOG_LEVEL;
      process.env.LOG_LEVEL = 'debug';
      
      const consoleSpy = jest.spyOn(console, 'debug').mockImplementation();
      
      logger.debug('Test debug message');
      
      expect(consoleSpy).toHaveBeenCalledWith('[DEBUG] Test debug message', {});
      
      consoleSpy.mockRestore();
      process.env.LOG_LEVEL = originalLogLevel;
    });
  });

  describe('File Logging', () => {
    it('should write info logs to app.log', () => {
      logger.info('Test file logging');
      
      expect(fs.existsSync(appLogPath)).toBe(true);
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      expect(logContent).toContain('Test file logging');
      expect(logContent).toContain('"level":"INFO"');
    });

    it('should write error logs to error.log', () => {
      logger.error('Test error logging');
      
      expect(fs.existsSync(errorLogPath)).toBe(true);
      const logContent = fs.readFileSync(errorLogPath, 'utf8');
      expect(logContent).toContain('Test error logging');
      expect(logContent).toContain('"level":"ERROR"');
    });

    it('should write warning logs to app.log', () => {
      logger.warn('Test warning logging');
      
      expect(fs.existsSync(appLogPath)).toBe(true);
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      expect(logContent).toContain('Test warning logging');
      expect(logContent).toContain('"level":"WARN"');
    });
  });

  describe('Structured Logging', () => {
    it('should log with metadata', () => {
      // Limpar log antes do teste
      if (fs.existsSync(appLogPath)) {
        fs.writeFileSync(appLogPath, '');
      }
      
      logger.info('Test with metadata', { userId: 123, action: 'test' });
      
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      const logLines = logContent.trim().split('\n');
      const lastLogLine = logLines[logLines.length - 1];
      const logEntry = JSON.parse(lastLogLine);
      
      expect(logEntry.message).toBe('Test with metadata');
      expect(logEntry.userId).toBe(123);
      expect(logEntry.action).toBe('test');
      expect(logEntry.level).toBe('INFO');
      expect(logEntry.timestamp).toBeDefined();
    });

    it('should format API request logs', () => {
      // Limpar log antes do teste
      if (fs.existsSync(appLogPath)) {
        fs.writeFileSync(appLogPath, '');
      }
      
      const mockReq = {
        method: 'GET',
        url: '/api/test',
        ip: '127.0.0.1',
        get: jest.fn().mockReturnValue('test-agent')
      };
      const mockRes = { statusCode: 200 };
      
      logger.apiRequest(mockReq, mockRes, 150);
      
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      const logLines = logContent.trim().split('\n');
      const lastLogLine = logLines[logLines.length - 1];
      const logEntry = JSON.parse(lastLogLine);
      
      expect(logEntry.message).toBe('API Request');
      expect(logEntry.method).toBe('GET');
      expect(logEntry.url).toBe('/api/test');
      expect(logEntry.statusCode).toBe(200);
      expect(logEntry.responseTime).toBe('150ms');
    });

    it('should format database query logs', () => {
      // Limpar log antes do teste
      if (fs.existsSync(appLogPath)) {
        fs.writeFileSync(appLogPath, '');
      }
      
      // Configurar LOG_LEVEL para debug
      const originalLogLevel = process.env.LOG_LEVEL;
      process.env.LOG_LEVEL = 'debug';
      
      logger.databaseQuery('SELECT * FROM test', 50, 10);
      
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      const logLines = logContent.trim().split('\n');
      const lastLogLine = logLines[logLines.length - 1];
      
      if (lastLogLine) {
        const logEntry = JSON.parse(lastLogLine);
        expect(logEntry.message).toBe('Database Query');
        expect(logEntry.query).toContain('SELECT * FROM test');
        expect(logEntry.duration).toBe('50ms');
        expect(logEntry.rows).toBe(10);
      }
      
      // Restaurar LOG_LEVEL
      process.env.LOG_LEVEL = originalLogLevel;
    });

    it('should format auth event logs', () => {
      // Limpar log antes do teste
      if (fs.existsSync(appLogPath)) {
        fs.writeFileSync(appLogPath, '');
      }
      
      logger.authEvent('login', 'admin', true);
      
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      const logLines = logContent.trim().split('\n');
      const lastLogLine = logLines[logLines.length - 1];
      const logEntry = JSON.parse(lastLogLine);
      
      expect(logEntry.message).toBe('Authentication Event');
      expect(logEntry.event).toBe('login');
      expect(logEntry.username).toBe('admin');
      expect(logEntry.success).toBe(true);
    });

    it('should format admin action logs', () => {
      // Limpar log antes do teste
      if (fs.existsSync(appLogPath)) {
        fs.writeFileSync(appLogPath, '');
      }
      
      logger.adminAction('create_user', 'admin', { userId: 456 });
      
      const logContent = fs.readFileSync(appLogPath, 'utf8');
      const logLines = logContent.trim().split('\n');
      const lastLogLine = logLines[logLines.length - 1];
      const logEntry = JSON.parse(lastLogLine);
      
      expect(logEntry.message).toBe('Admin Action');
      expect(logEntry.action).toBe('create_user');
      expect(logEntry.username).toBe('admin');
      expect(logEntry.details.userId).toBe(456);
    });
  });
});
