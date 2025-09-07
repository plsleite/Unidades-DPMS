const express = require('express');
const { query } = require('../database');
const router = express.Router();

// =========================
// ENDPOINTS DE UNIDADES
// =========================

// GET /api/unidades - Listar todas as unidades
router.get('/unidades', async (req, res) => {
  try {
    const { regional, search } = req.query;
    
    let sql = `
      SELECT 
        u.id,
        u.nome,
        u.endereco,
        u.telefone,
        u.regional_id,
        u.coordenador,
        u.email_coordenador,
        u.supervisor,
        u.email_supervisor,
        r.nome as regional_nome,
        r.numero as regional_numero
      FROM unidades u
      LEFT JOIN regionais r ON u.regional_id = r.id
    `;
    
    const params = [];
    const conditions = [];
    
    // Filtro por regional
    if (regional) {
      conditions.push('u.regional_id = $' + (params.length + 1));
      params.push(parseInt(regional));
    }
    
    // Filtro por busca (nome, endereço, telefone)
    if (search) {
      conditions.push(`(
        LOWER(u.nome) LIKE LOWER($${params.length + 1}) OR
        LOWER(u.endereco) LIKE LOWER($${params.length + 1}) OR
        LOWER(u.telefone) LIKE LOWER($${params.length + 1}) OR
        LOWER(r.nome) LIKE LOWER($${params.length + 1})
      )`);
      params.push(`%${search}%`);
    }
    
    if (conditions.length > 0) {
      sql += ' WHERE ' + conditions.join(' AND ');
    }
    
    sql += ' ORDER BY u.nome';
    
    const result = await query(sql, params);
    res.json(result.rows);
    
  } catch (error) {
    console.error('Erro ao buscar unidades:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/unidades/:id - Buscar unidade específica
router.get('/unidades/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const sql = `
      SELECT 
        u.*,
        r.nome as regional_nome,
        r.numero as regional_numero
      FROM unidades u
      LEFT JOIN regionais r ON u.regional_id = r.id
      WHERE u.id = $1
    `;
    
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Unidade não encontrada' });
    }
    
    res.json(result.rows[0]);
    
  } catch (error) {
    console.error('Erro ao buscar unidade:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINTS DE ÓRGÃOS
// =========================

// GET /api/orgaos - Listar todos os órgãos
router.get('/orgaos', async (req, res) => {
  try {
    const { unidade_id, vaga, afastado, search } = req.query;
    
    let sql = `
      SELECT 
        o.id,
        o.nome,
        o.unidade_id,
        o.titular_nome,
        o.titular_email,
        o.titular_afastado,
        o.vaga,
        o.substituto_nome,
        o.substituto_email,
        u.nome as unidade_nome
      FROM orgaos o
      LEFT JOIN unidades u ON o.unidade_id = u.id
    `;
    
    const params = [];
    const conditions = [];
    
    // Filtro por unidade
    if (unidade_id) {
      conditions.push('o.unidade_id = $' + (params.length + 1));
      params.push(parseInt(unidade_id));
    }
    
    // Filtro por vaga
    if (vaga === 'true') {
      conditions.push('o.vaga = true');
    }
    
    // Filtro por afastado
    if (afastado === 'true') {
      conditions.push('o.titular_afastado = true');
    }
    
    // Filtro por busca
    if (search) {
      conditions.push(`(
        LOWER(o.nome) LIKE LOWER($${params.length + 1}) OR
        LOWER(o.titular_nome) LIKE LOWER($${params.length + 1}) OR
        LOWER(o.titular_email) LIKE LOWER($${params.length + 1}) OR
        LOWER(o.substituto_nome) LIKE LOWER($${params.length + 1}) OR
        LOWER(o.substituto_email) LIKE LOWER($${params.length + 1}) OR
        LOWER(u.nome) LIKE LOWER($${params.length + 1})
      )`);
      params.push(`%${search}%`);
    }
    
    if (conditions.length > 0) {
      sql += ' WHERE ' + conditions.join(' AND ');
    }
    
    sql += ' ORDER BY u.nome, o.nome';
    
    const result = await query(sql, params);
    res.json(result.rows);
    
  } catch (error) {
    console.error('Erro ao buscar órgãos:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINTS DE REGIONAIS
// =========================

// GET /api/regionais - Listar todas as regionais
router.get('/regionais', async (req, res) => {
  try {
    const sql = 'SELECT * FROM regionais ORDER BY numero';
    const result = await query(sql);
    res.json(result.rows);
    
  } catch (error) {
    console.error('Erro ao buscar regionais:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINT COMBINADO - UNIDADES COM ÓRGÃOS
// =========================

// GET /api/unidades-completas - Unidades com seus órgãos
router.get('/unidades-completas', async (req, res) => {
  try {
    const { regional, search, vaga, afastado } = req.query;
    
    // Buscar unidades
    let unidadesSql = `
      SELECT 
        u.id,
        u.nome,
        u.endereco,
        u.telefone,
        u.regional_id,
        u.coordenador,
        u.email_coordenador,
        u.supervisor,
        u.email_supervisor,
        r.nome as regional_nome,
        r.numero as regional_numero
      FROM unidades u
      LEFT JOIN regionais r ON u.regional_id = r.id
    `;
    
    const params = [];
    const conditions = [];
    
    if (regional) {
      conditions.push('u.regional_id = $' + (params.length + 1));
      params.push(parseInt(regional));
    }
    
    if (search) {
      conditions.push(`(
        LOWER(u.nome) LIKE LOWER($${params.length + 1}) OR
        LOWER(u.endereco) LIKE LOWER($${params.length + 1}) OR
        LOWER(u.telefone) LIKE LOWER($${params.length + 1}) OR
        LOWER(r.nome) LIKE LOWER($${params.length + 1})
      )`);
      params.push(`%${search}%`);
    }
    
    if (conditions.length > 0) {
      unidadesSql += ' WHERE ' + conditions.join(' AND ');
    }
    
    unidadesSql += ' ORDER BY u.nome';
    
    const unidadesResult = await query(unidadesSql, params);
    const unidades = unidadesResult.rows;
    
    // Para cada unidade, buscar seus órgãos
    for (let unidade of unidades) {
      let orgaosSql = `
        SELECT 
          id,
          nome,
          titular_nome,
          titular_email,
          titular_afastado,
          vaga,
          substituto_nome,
          substituto_email
        FROM orgaos
        WHERE unidade_id = $1
      `;
      
      const orgaosParams = [unidade.id];
      
      // Aplicar filtros aos órgãos
      if (vaga === 'true') {
        orgaosSql += ' AND vaga = true';
      }
      
      if (afastado === 'true') {
        orgaosSql += ' AND titular_afastado = true';
      }
      
      orgaosSql += ' ORDER BY nome';
      
      const orgaosResult = await query(orgaosSql, orgaosParams);
      unidade.orgaos = orgaosResult.rows;
    }
    
    res.json(unidades);
    
  } catch (error) {
    console.error('Erro ao buscar unidades completas:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

module.exports = router;
