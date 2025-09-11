const logger = require('../utils/logger');

// Middleware para logging de requisições HTTP
const requestLogger = (req, res, next) => {
  const start = Date.now();
  
  // Interceptar o método end da resposta
  const originalEnd = res.end;
  res.end = function(...args) {
    const responseTime = Date.now() - start;
    logger.apiRequest(req, res, responseTime);
    originalEnd.apply(this, args);
  };
  
  next();
};

// Middleware para logging de erros
const errorLogger = (err, req, res, next) => {
  logger.error('Unhandled Error', {
    error: err.message,
    stack: err.stack,
    url: req.url,
    method: req.method,
    ip: req.ip
  });
  
  next(err);
};

module.exports = {
  requestLogger,
  errorLogger
};
