# 📋 **INSTRUÇÕES PARA INSERÇÃO COMPLETA - 248 DEFENSORIAS**

## 🎯 **OBJETIVO**
Inserir todas as **248 defensorias** da lista completa no banco de dados PostgreSQL.

## 📊 **DADOS A SEREM INSERIDOS**
- ✅ **13 regionais**
- ✅ **65 unidades** 
- ✅ **248 defensorias** (órgãos)

## 🗂️ **ARQUIVOS CRIADOS**

### **Scripts de Limpeza:**
- `limpar-banco.sql` - Limpa todas as tabelas

### **Scripts de Inserção:**
- `insert-completo.sql` - Insere regionais e unidades (65 unidades)
- `insert-defensorias-parte1.sql` - Insere defensorias 1-20 (unidades 1-20)
- `insert-defensorias-parte2.sql` - Insere defensorias 21-40 (unidades 21-40) 
- `insert-defensorias-parte3.sql` - Insere defensorias 41-60 (unidades 41-60)
- `insert-defensorias-parte4.sql` - Insere defensorias 61-65 (unidades 61-65)

### **Script de Execução:**
- `EXECUTAR-TODOS-OS-SCRIPTS.sql` - Script de demonstração (apenas primeiras 20 unidades)

## 🚀 **PROCESSO DE EXECUÇÃO**

### **PASSO 1: Limpar Banco de Dados**
```sql
-- Execute no pgAdmin4:
limpar-banco.sql
```

### **PASSO 2: Inserir Regionais e Unidades**
```sql
-- Execute no pgAdmin4:
insert-completo.sql
```

### **PASSO 3: Inserir Defensorias (4 partes)**
```sql
-- Execute no pgAdmin4 em sequência:
insert-defensorias-parte1.sql
insert-defensorias-parte2.sql
insert-defensorias-parte3.sql
insert-defensorias-parte4.sql
```

### **PASSO 4: Reiniciar Servidor**
```bash
# No terminal:
lsof -ti:3000 | xargs kill -9
node server.js
```

### **PASSO 5: Verificar Resultado**
- Acesse: `http://localhost:3000`
- Verifique se todas as 65 unidades aparecem
- Verifique se todas as 248 defensorias aparecem

## ✅ **VERIFICAÇÃO FINAL**

Após executar todos os scripts, você deve ter:
- **13 regionais**
- **65 unidades**
- **248 defensorias**

## 🔍 **CONTAGEM POR UNIDADE**

### **Unidades com mais defensorias:**
- **CAMPO GRANDE | 2ª INSTÂNCIA:** 37 defensorias
- **CAMPO GRANDE | CENTRO/NUCCON:** 20 defensorias
- **CAMPO GRANDE | FÓRUM/NUCRIM:** 22 defensorias
- **CAMPO GRANDE | BELMAR FIDALGO/NUFAM:** 16 defensorias
- **DOURADOS | CIVEL II:** 10 defensorias
- **CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN:** 10 defensorias

### **Unidades com 1 defensoria:**
- Água Clara, Anastácio, Anaurilândia, Angélica, Batayporã, Bela Vista, Brasilândia, etc.

## ⚠️ **IMPORTANTE**

1. **Execute os scripts na ordem correta**
2. **Aguarde cada script terminar antes do próximo**
3. **Verifique se não há erros no pgAdmin4**
4. **Reinicie o servidor após todos os scripts**

## 🎉 **RESULTADO ESPERADO**

Após a execução completa, o site deve mostrar:
- **65 unidades** na página principal
- **248 defensorias** distribuídas entre as unidades
- **Dados completos** com titulares, substitutos, status de vagas, etc.

---

**📞 Suporte:** Se houver algum erro, verifique os logs do pgAdmin4 e do servidor Node.js.
