// Configurações do banco de dados
const config = {
  development: {
    database: {
      host: 'localhost',
      port: 5432,
      database: 'defensoria_ms',
      user: 'postgres', // Substitua pelo seu usuário
      password: 'nova_senha_segura', // Substitua pela sua senha
      max: 20, // Máximo de conexões no pool
      idleTimeoutMillis: 30000,
      connectionTimeoutMillis: 2000,
    },
    server: {
      port: 3000
    },
    jwt: {
      secret: 'seu_jwt_secret_aqui' // Para autenticação futura
    }
  }
};

module.exports = config[process.env.NODE_ENV || 'development'];
