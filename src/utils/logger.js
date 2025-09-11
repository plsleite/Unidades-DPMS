const fs = require('fs');
const path = require('path');

class Logger {
  constructor() {
    this.logDir = path.join(__dirname, '../../logs');
    this.ensureLogDirectory();
  }

  ensureLogDirectory() {
    if (!fs.existsSync(this.logDir)) {
      fs.mkdirSync(this.logDir, { recursive: true });
    }
  }

  formatMessage(level, message, meta = {}) {
    const timestamp = new Date().toISOString();
    const logEntry = {
      timestamp,
      level,
      message,
      ...meta
    };
    return JSON.stringify(logEntry) + '\n';
  }

  writeToFile(filename, message) {
    const filePath = path.join(this.logDir, filename);
    fs.appendFileSync(filePath, message);
  }

  info(message, meta = {}) {
    const formatted = this.formatMessage('INFO', message, meta);
    console.log(`[INFO] ${message}`, meta);
    this.writeToFile('app.log', formatted);
  }

  error(message, meta = {}) {
    const formatted = this.formatMessage('ERROR', message, meta);
    console.error(`[ERROR] ${message}`, meta);
    this.writeToFile('error.log', formatted);
  }

  warn(message, meta = {}) {
    const formatted = this.formatMessage('WARN', message, meta);
    console.warn(`[WARN] ${message}`, meta);
    this.writeToFile('app.log', formatted);
  }

  debug(message, meta = {}) {
    if (process.env.LOG_LEVEL === 'debug') {
      const formatted = this.formatMessage('DEBUG', message, meta);
      console.debug(`[DEBUG] ${message}`, meta);
      this.writeToFile('debug.log', formatted);
    }
  }

  // Logs específicos para diferentes tipos de eventos
  apiRequest(req, res, responseTime) {
    this.info('API Request', {
      method: req.method,
      url: req.url,
      ip: req.ip,
      userAgent: req.get('User-Agent'),
      statusCode: res.statusCode,
      responseTime: `${responseTime}ms`
    });
  }

  databaseQuery(query, duration, rows) {
    this.debug('Database Query', {
      query: query.substring(0, 100) + '...',
      duration: `${duration}ms`,
      rows: rows
    });
  }

  authEvent(event, username, success) {
    this.info('Authentication Event', {
      event,
      username,
      success,
      timestamp: new Date().toISOString()
    });
  }

  adminAction(action, username, details = {}) {
    this.info('Admin Action', {
      action,
      username,
      details,
      timestamp: new Date().toISOString()
    });
  }
}

module.exports = new Logger();
