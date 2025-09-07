const { Pool } = require('pg');
const config = require('./config');

// Criar pool de conexões com PostgreSQL
const pool = new Pool(config.database);

// Testar conexão
pool.on('connect', () => {
  console.log('✅ Conectado ao PostgreSQL');
});

pool.on('error', (err) => {
  console.error('❌ Erro na conexão PostgreSQL:', err);
  process.exit(-1);
});

// Função para testar a conexão
const testConnection = async () => {
  try {
    const client = await pool.connect();
    console.log('🔍 Testando conexão com o banco...');
    
    // Testar consulta simples
    const result = await client.query('SELECT NOW()');
    console.log('✅ Conexão funcionando! Hora atual:', result.rows[0].now);
    
    client.release();
    return true;
  } catch (err) {
    console.error('❌ Erro ao conectar com o banco:', err.message);
    return false;
  }
};

// Função para executar queries
const query = async (text, params) => {
  const start = Date.now();
  try {
    const res = await pool.query(text, params);
    const duration = Date.now() - start;
    console.log('📊 Query executada:', { text, duration, rows: res.rowCount });
    return res;
  } catch (err) {
    console.error('❌ Erro na query:', err.message);
    throw err;
  }
};

// Função para obter cliente do pool
const getClient = async () => {
  return await pool.connect();
};

module.exports = {
  pool,
  query,
  getClient,
  testConnection
};
