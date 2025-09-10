# 🔌 Documentação da API - Sistema de Unidades DPMS

## 📋 Visão Geral

A API do Sistema de Unidades DPMS fornece endpoints para consulta e gerenciamento de dados das unidades e defensorias da Defensoria Pública de Mato Grosso do Sul.

**Base URL**: `http://localhost:3000/api`

## 🔐 Autenticação

A API utiliza JWT (JSON Web Tokens) para autenticação.

### **Login**
```http
POST /api/auth/login
Content-Type: application/json

{
  "username": "admin",
  "password": "admin123"
}
```

**Resposta de Sucesso:**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "admin",
    "coordenacao": "Administração"
  }
}
```

### **Uso do Token**
```http
Authorization: Bearer <seu_token_aqui>
```

## 📊 Endpoints de Dados

### **1. Listar Todas as Unidades**
```http
GET /api/unidades
```

**Resposta:**
```json
[
  {
    "id": 1,
    "nome": "CAMPO GRANDE | 2ª INSTÂNCIA",
    "regional": "CAMPO GRANDE",
    "endereco": "Rua 14 de Julho, 2060",
    "telefone": "(67) 3314-1000",
    "defensorias": [
      {
        "id": 1,
        "nome": "1ª CÂMARA CÍVEL",
        "titular": "Dr. João Silva",
        "substituto": "Dr. Maria Santos",
        "vaga": false,
        "afastado": false
      }
    ]
  }
]
```

### **2. Buscar Unidade por ID**
```http
GET /api/unidades/:id
```

**Parâmetros:**
- `id` (number): ID da unidade

**Resposta:**
```json
{
  "id": 1,
  "nome": "CAMPO GRANDE | 2ª INSTÂNCIA",
  "regional": "CAMPO GRANDE",
  "endereco": "Rua 14 de Julho, 2060",
  "telefone": "(67) 3314-1000",
  "defensorias": [...]
}
```

### **3. Filtrar Unidades por Regional**
```http
GET /api/unidades?regional=CAMPO GRANDE
```

**Parâmetros de Query:**
- `regional` (string): Nome da regional
- `search` (string): Busca por nome da unidade

### **4. Listar Regionais**
```http
GET /api/regionais
```

**Resposta:**
```json
[
  {
    "id": 1,
    "nome": "CAMPO GRANDE",
    "unidades_count": 15
  },
  {
    "id": 2,
    "nome": "DOURADOS",
    "unidades_count": 8
  }
]
```

### **5. Estatísticas Gerais**
```http
GET /api/stats
```

**Resposta:**
```json
{
  "total_unidades": 65,
  "total_defensorias": 249,
  "defensorias_vagas": 46,
  "titulares_afastados": 20,
  "total_regionais": 13,
  "por_regional": [
    {
      "regional": "CAMPO GRANDE",
      "unidades": 15,
      "defensorias": 85,
      "vagas": 12,
      "afastados": 5
    }
  ]
}
```

### **6. Defensorias com Problemas**
```http
GET /api/defensorias/problemas
```

**Resposta:**
```json
{
  "vagas": [
    {
      "id": 15,
      "nome": "3ª CÂMARA CÍVEL",
      "unidade": "CAMPO GRANDE | 2ª INSTÂNCIA",
      "dias_vaga": 30
    }
  ],
  "afastados": [
    {
      "id": 23,
      "nome": "1ª CÂMARA CRIMINAL",
      "unidade": "DOURADOS | CRIMINAL",
      "titular": "Dr. Pedro Silva",
      "dias_afastado": 15
    }
  ]
}
```

## 🔧 Endpoints Administrativos

### **1. Atualizar Defensoria**
```http
PUT /api/defensorias/:id
Authorization: Bearer <token>
Content-Type: application/json

{
  "titular": "Dr. Novo Titular",
  "substituto": "Dr. Novo Substituto",
  "vaga": false,
  "afastado": false
}
```

### **2. Criar Nova Defensoria**
```http
POST /api/defensorias
Authorization: Bearer <token>
Content-Type: application/json

{
  "nome": "Nova Defensoria",
  "unidade_id": 1,
  "titular": "Dr. Titular",
  "substituto": "Dr. Substituto"
}
```

### **3. Deletar Defensoria**
```http
DELETE /api/defensorias/:id
Authorization: Bearer <token>
```

## 📈 Endpoints de Relatórios

### **1. Relatório por Regional**
```http
GET /api/relatorios/regional/:id
```

### **2. Relatório de Vagas**
```http
GET /api/relatorios/vagas?dias=30
```

### **3. Relatório de Afastamentos**
```http
GET /api/relatorios/afastamentos?dias=30
```

## 🔍 Endpoints de Busca

### **1. Busca Global**
```http
GET /api/search?q=termo
```

**Parâmetros:**
- `q` (string): Termo de busca
- `type` (string): Tipo de busca (unidade, defensoria, regional)

### **2. Busca Avançada**
```http
POST /api/search/advanced
Content-Type: application/json

{
  "regional": "CAMPO GRANDE",
  "vaga": true,
  "afastado": false
}
```

## 📊 Códigos de Resposta

| Código | Descrição |
|--------|-----------|
| 200 | Sucesso |
| 201 | Criado com sucesso |
| 400 | Requisição inválida |
| 401 | Não autorizado |
| 403 | Acesso negado |
| 404 | Não encontrado |
| 500 | Erro interno do servidor |

## 🔄 Paginação

Para endpoints que retornam listas, use os parâmetros:

```http
GET /api/unidades?page=1&limit=10&offset=0
```

**Parâmetros:**
- `page` (number): Página atual (padrão: 1)
- `limit` (number): Itens por página (padrão: 10)
- `offset` (number): Deslocamento (padrão: 0)

**Resposta Paginada:**
```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 65,
    "pages": 7
  }
}
```

## 🔍 Filtros e Ordenação

### **Filtros Disponíveis**
- `regional`: Filtrar por regional
- `vaga`: Filtrar defensorias vagas
- `afastado`: Filtrar titulares afastados
- `search`: Busca textual

### **Ordenação**
```http
GET /api/unidades?sort=nome&order=asc
```

**Parâmetros:**
- `sort` (string): Campo para ordenação
- `order` (string): Direção (asc/desc)

## 📱 Exemplos de Uso

### **JavaScript (Frontend)**
```javascript
// Buscar todas as unidades
fetch('/api/unidades')
  .then(response => response.json())
  .then(data => console.log(data));

// Buscar com filtro
fetch('/api/unidades?regional=CAMPO GRANDE')
  .then(response => response.json())
  .then(data => console.log(data));

// Login
fetch('/api/auth/login', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    username: 'admin',
    password: 'admin123'
  })
})
.then(response => response.json())
.then(data => {
  localStorage.setItem('token', data.token);
});
```

### **cURL**
```bash
# Listar unidades
curl -X GET http://localhost:3000/api/unidades

# Buscar unidade específica
curl -X GET http://localhost:3000/api/unidades/1

# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

## ⚠️ Limitações e Considerações

### **Rate Limiting**
- 100 requests por IP a cada 15 minutos
- 1000 requests por token a cada hora

### **Tamanho de Resposta**
- Máximo 10MB por resposta
- Paginação automática para listas grandes

### **Cache**
- Respostas são cacheadas por 5 minutos
- Use headers apropriados para invalidação

## 🔧 Troubleshooting

### **Erro 401 - Não Autorizado**
- Verificar se o token está presente
- Verificar se o token é válido
- Fazer login novamente

### **Erro 500 - Erro Interno**
- Verificar logs do servidor
- Verificar conexão com banco de dados
- Verificar configurações

### **Timeout**
- Verificar performance do banco
- Verificar complexidade da consulta
- Considerar paginação

## 📞 Suporte

Para problemas com a API:
1. Verificar logs do servidor
2. Testar endpoints com ferramentas como Postman
3. Verificar documentação do banco de dados
4. Abrir issue no repositório
