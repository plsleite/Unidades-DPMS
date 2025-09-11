# Use Node.js 18 Alpine como base (menor e mais seguro)
FROM node:18-alpine

# Instalar dependências do sistema necessárias para PostgreSQL
RUN apk add --no-cache postgresql-client

# Criar diretório da aplicação
WORKDIR /app

# Copiar package.json e package-lock.json
COPY package*.json ./

# Instalar dependências
RUN npm ci --only=production

# Copiar código da aplicação
COPY . .

# Criar diretório de logs
RUN mkdir -p logs

# Expor porta 3000
EXPOSE 3000

# Criar usuário não-root para segurança
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

# Comando para iniciar a aplicação
CMD ["npm", "start"]
