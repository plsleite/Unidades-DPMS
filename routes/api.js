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
    
    sql += ' ORDER BY UPPER(u.nome)';
    
    const result = await query(sql, params);
    const unidades = result.rows;
    
    // Para cada unidade, buscar suas coordenações
    for (let unidade of unidades) {
      const coordenacoesSql = `
        SELECT 
          id,
          tipo_coordenacao,
          nome_coordenador,
          email_coordenador,
          ativo
        FROM coordenacoes
        WHERE unidade_id = $1 AND ativo = true
        ORDER BY 
          CASE tipo_coordenacao 
            WHEN 'ADMINISTRATIVA' THEN 1
            WHEN 'CIVEL' THEN 2
            WHEN 'CRIMINAL' THEN 3
            ELSE 4
          END
      `;
      
      const coordenacoesResult = await query(coordenacoesSql, [unidade.id]);
      unidade.coordenacoes = coordenacoesResult.rows;
    }
    
    res.json(unidades);
    
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
    
    const unidade = result.rows[0];
    
    // Buscar coordenações da unidade
    const coordenacoesSql = `
      SELECT 
        id,
        tipo_coordenacao,
        nome_coordenador,
        email_coordenador,
        ativo
      FROM coordenacoes
      WHERE unidade_id = $1 AND ativo = true
      ORDER BY 
        CASE tipo_coordenacao 
          WHEN 'ADMINISTRATIVA' THEN 1
          WHEN 'CIVEL' THEN 2
          WHEN 'CRIMINAL' THEN 3
          ELSE 4
        END
    `;
    
    const coordenacoesResult = await query(coordenacoesSql, [id]);
    unidade.coordenacoes = coordenacoesResult.rows;
    
    res.json(unidade);
    
  } catch (error) {
    console.error('Erro ao buscar unidade:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// POST /api/unidades - Criar nova unidade
router.post('/unidades', async (req, res) => {
  try {
    const { 
      nome, 
      endereco, 
      telefone, 
      regional_id, 
      coordenador, 
      email_coordenador, 
      supervisor, 
      email_supervisor 
    } = req.body;

    // Validações básicas
    if (!nome || !endereco) {
      return res.status(400).json({ error: 'Nome e endereço são obrigatórios' });
    }

    const sql = `
      INSERT INTO unidades (
        nome, endereco, telefone, regional_id, 
        coordenador, email_coordenador, supervisor, email_supervisor
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING *
    `;

    const params = [
      nome, 
      endereco, 
      telefone || null, 
      regional_id || null, 
      coordenador || null, 
      email_coordenador || null, 
      supervisor || null, 
      email_supervisor || null
    ];

    const result = await query(sql, params);
    
    res.status(201).json({
      success: true,
      message: 'Unidade criada com sucesso',
      unidade: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao criar unidade:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// PUT /api/unidades/:id - Atualizar unidade
router.put('/unidades/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { 
      nome, 
      endereco, 
      telefone, 
      regional_id, 
      coordenador, 
      email_coordenador, 
      supervisor, 
      email_supervisor 
    } = req.body;

    // Validações básicas
    if (!nome || !endereco) {
      return res.status(400).json({ error: 'Nome e endereço são obrigatórios' });
    }

    const sql = `
      UPDATE unidades SET 
        nome = $1, 
        endereco = $2, 
        telefone = $3, 
        regional_id = $4, 
        coordenador = $5, 
        email_coordenador = $6, 
        supervisor = $7, 
        email_supervisor = $8
      WHERE id = $9
      RETURNING *
    `;

    const params = [
      nome, 
      endereco, 
      telefone || null, 
      regional_id || null, 
      coordenador || null, 
      email_coordenador || null, 
      supervisor || null, 
      email_supervisor || null,
      id
    ];

    const result = await query(sql, params);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Unidade não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Unidade atualizada com sucesso',
      unidade: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao atualizar unidade:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// DELETE /api/unidades/:id - Excluir unidade
router.delete('/unidades/:id', async (req, res) => {
  try {
    const { id } = req.params;

    // Verificar se a unidade tem defensorias
    const orgaosResult = await query('SELECT COUNT(*) as count FROM orgaos WHERE unidade_id = $1', [id]);
    const orgaosCount = parseInt(orgaosResult.rows[0].count);

    if (orgaosCount > 0) {
      return res.status(400).json({ 
        error: 'Não é possível excluir unidade que possui defensorias vinculadas',
        orgaosCount 
      });
    }

    const sql = 'DELETE FROM unidades WHERE id = $1 RETURNING *';
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Unidade não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Unidade excluída com sucesso'
    });
    
  } catch (error) {
    console.error('Erro ao excluir unidade:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINTS DE DEFENSORIAS
// =========================

// GET /api/orgaos - Listar todas as defensorias
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
        o.data_vacancia,
        o.portaria_vacancia,
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
    
    sql += ' ORDER BY UPPER(u.nome), CAST(SUBSTRING(o.nome FROM \'^([0-9]+)\') AS INTEGER), o.nome';
    
    const result = await query(sql, params);
    res.json(result.rows);
    
  } catch (error) {
    console.error('Erro ao buscar defensorias:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/orgaos/:id - Buscar defensoria específica
router.get('/orgaos/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const sql = `
      SELECT 
        o.*,
        u.nome as unidade_nome
      FROM orgaos o
      LEFT JOIN unidades u ON o.unidade_id = u.id
      WHERE o.id = $1
    `;
    
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Defensoria não encontrada' });
    }
    
    res.json(result.rows[0]);
    
  } catch (error) {
    console.error('Erro ao buscar defensoria:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// POST /api/orgaos - Criar nova defensoria
router.post('/orgaos', async (req, res) => {
  try {
    const { 
      nome, 
      unidade_id, 
      titular_nome, 
      titular_email, 
      titular_afastado, 
      vaga, 
      data_vacancia,
      portaria_vacancia,
      substituto_nome, 
      substituto_email 
    } = req.body;

    // Validações básicas
    if (!nome || !unidade_id) {
      return res.status(400).json({ error: 'Nome e unidade são obrigatórios' });
    }

    const sql = `
      INSERT INTO orgaos (
        nome, unidade_id, titular_nome, titular_email, 
        titular_afastado, vaga, data_vacancia, portaria_vacancia, substituto_nome, substituto_email
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *
    `;

    const params = [
      nome, 
      unidade_id, 
      titular_nome || null, 
      titular_email || null, 
      titular_afastado || false, 
      vaga || false, 
      data_vacancia || null,
      portaria_vacancia || null,
      substituto_nome || null, 
      substituto_email || null
    ];

    const result = await query(sql, params);
    
    res.status(201).json({
      success: true,
      message: 'Defensoria criada com sucesso',
      orgao: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao criar defensoria:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// PUT /api/orgaos/:id - Atualizar defensoria
router.put('/orgaos/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { 
      nome, 
      unidade_id, 
      titular_nome, 
      titular_email, 
      titular_afastado, 
      vaga, 
      data_vacancia,
      portaria_vacancia,
      substituto_nome, 
      substituto_email 
    } = req.body;

    // Validações básicas
    if (!nome || !unidade_id) {
      return res.status(400).json({ error: 'Nome e unidade são obrigatórios' });
    }

    const sql = `
      UPDATE orgaos SET 
        nome = $1, 
        unidade_id = $2, 
        titular_nome = $3, 
        titular_email = $4, 
        titular_afastado = $5, 
        vaga = $6, 
        data_vacancia = $7,
        portaria_vacancia = $8,
        substituto_nome = $9, 
        substituto_email = $10
      WHERE id = $11
      RETURNING *
    `;

    const params = [
      nome, 
      unidade_id, 
      titular_nome || null, 
      titular_email || null, 
      titular_afastado || false, 
      vaga || false, 
      data_vacancia || null,
      portaria_vacancia || null,
      substituto_nome || null, 
      substituto_email || null,
      id
    ];

    const result = await query(sql, params);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Defensoria não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Defensoria atualizada com sucesso',
      orgao: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao atualizar defensoria:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// DELETE /api/orgaos/:id - Excluir defensoria
router.delete('/orgaos/:id', async (req, res) => {
  try {
    const { id } = req.params;

    const sql = 'DELETE FROM orgaos WHERE id = $1 RETURNING *';
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Defensoria não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Defensoria excluída com sucesso'
    });
    
  } catch (error) {
    console.error('Erro ao excluir defensoria:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINT COMBINADO - UNIDADES COM DEFENSORIAS
// =========================

// GET /api/unidades-completas - Unidades com suas defensorias
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
    
    unidadesSql += ' ORDER BY UPPER(u.nome)';
    
    const unidadesResult = await query(unidadesSql, params);
    const unidades = unidadesResult.rows;
    
    // Para cada unidade, buscar suas defensorias e coordenações
    for (let unidade of unidades) {
      // Buscar defensorias
      let orgaosSql = `
        SELECT 
          id,
          nome,
          titular_nome,
          titular_email,
          titular_afastado,
          vaga,
          data_vacancia,
          portaria_vacancia,
          substituto_nome,
          substituto_email
        FROM orgaos
        WHERE unidade_id = $1
      `;
      
      const orgaosParams = [unidade.id];
      
      // Aplicar filtros às defensorias
      if (vaga === 'true') {
        orgaosSql += ' AND vaga = true';
      }
      
      if (afastado === 'true') {
        orgaosSql += ' AND titular_afastado = true';
      }
      
      orgaosSql += ' ORDER BY CAST(SUBSTRING(nome FROM \'^([0-9]+)\') AS INTEGER), nome';
      
      const orgaosResult = await query(orgaosSql, orgaosParams);
      unidade.orgaos = orgaosResult.rows;
      
      // Buscar coordenações
      const coordenacoesSql = `
        SELECT 
          id,
          tipo_coordenacao,
          nome_coordenador,
          email_coordenador,
          ativo
        FROM coordenacoes
        WHERE unidade_id = $1 AND ativo = true
        ORDER BY 
          CASE tipo_coordenacao 
            WHEN 'ADMINISTRATIVA' THEN 1
            WHEN 'CIVEL' THEN 2
            WHEN 'CRIMINAL' THEN 3
            ELSE 4
          END
      `;
      
      const coordenacoesResult = await query(coordenacoesSql, [unidade.id]);
      unidade.coordenacoes = coordenacoesResult.rows;
    }
    
    res.json(unidades);
    
  } catch (error) {
    console.error('Erro ao buscar unidades completas:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINTS DO DASHBOARD
// =========================

// GET /api/dashboard/stats - Estatísticas gerais
router.get('/dashboard/stats', async (req, res) => {
  try {
    const sql = `
      SELECT 
        (SELECT COUNT(*) FROM unidades) as total_unidades,
        (SELECT COUNT(*) FROM orgaos) as total_defensorias,
        (SELECT COUNT(*) FROM orgaos WHERE vaga = true) as defensorias_vagas,
        (SELECT COUNT(*) FROM orgaos WHERE titular_afastado = true) as titulares_afastados,
        (SELECT COUNT(*) FROM regionais) as total_regionais
    `;
    
    const result = await query(sql);
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Erro ao buscar estatísticas:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/dashboard/regionais - Dados por regional
router.get('/dashboard/regionais', async (req, res) => {
  try {
    const sql = `
      -- Dados das regionais normais
      SELECT 
        r.id,
        r.nome,
        r.numero,
        COUNT(DISTINCT u.id) as total_unidades,
        COUNT(o.id) as total_defensorias,
        COUNT(CASE WHEN o.vaga = true THEN 1 END) as defensorias_vagas,
        COUNT(CASE WHEN o.titular_afastado = true THEN 1 END) as titulares_afastados
      FROM regionais r
      LEFT JOIN unidades u ON r.id = u.regional_id
      LEFT JOIN orgaos o ON u.id = o.unidade_id
      GROUP BY r.id, r.nome, r.numero
      
      UNION ALL
      
      -- Dados da unidade CAMPO GRANDE | 2ª INSTÂNCIA como "Segunda Instância"
      SELECT 
        999 as id,
        'Segunda Instância' as nome,
        99 as numero,
        1 as total_unidades,
        COUNT(o.id) as total_defensorias,
        COUNT(CASE WHEN o.vaga = true THEN 1 END) as defensorias_vagas,
        COUNT(CASE WHEN o.titular_afastado = true THEN 1 END) as titulares_afastados
      FROM unidades u
      LEFT JOIN orgaos o ON u.id = o.unidade_id
      WHERE u.nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'
      
      ORDER BY numero
    `;
    
    const result = await query(sql);
    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar dados por regional:', error);
    res.status(500).json({ error: 'Erro interno do servidor', details: error.message });
  }
});

// GET /api/dashboard/unidades - Dados por unidade
router.get('/dashboard/unidades', async (req, res) => {
  try {
    const sql = `
      SELECT 
        u.id,
        u.nome,
        r.nome as regional_nome,
        r.numero as regional_numero,
        COUNT(o.id) as total_defensorias,
        COUNT(CASE WHEN o.vaga = true THEN 1 END) as defensorias_vagas,
        COUNT(CASE WHEN o.titular_afastado = true THEN 1 END) as titulares_afastados
      FROM unidades u
      LEFT JOIN regionais r ON u.regional_id = r.id
      LEFT JOIN orgaos o ON u.id = o.unidade_id
      GROUP BY u.id, u.nome, r.nome, r.numero
      ORDER BY UPPER(u.nome)
    `;
    
    const result = await query(sql);
    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar dados por unidade:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/dashboard/problemas - Defensorias com problemas
router.get('/dashboard/problemas', async (req, res) => {
  try {
    const sql = `
      SELECT 
        o.id,
        o.nome,
        u.nome as unidade_nome,
        r.nome as regional_nome,
        o.titular_nome,
        o.titular_afastado,
        o.vaga,
        o.substituto_nome,
        CASE 
          WHEN o.vaga = true AND o.titular_afastado = true THEN 'Vaga e Afastado'
          WHEN o.vaga = true THEN 'Vaga'
          WHEN o.titular_afastado = true THEN 'Afastado'
          ELSE 'Normal'
        END as status
      FROM orgaos o
      LEFT JOIN unidades u ON o.unidade_id = u.id
      LEFT JOIN regionais r ON u.regional_id = r.id
      WHERE o.vaga = true OR o.titular_afastado = true
      ORDER BY 
        CASE 
          WHEN o.vaga = true AND o.titular_afastado = true THEN 1
          WHEN o.titular_afastado = true THEN 2
          WHEN o.vaga = true THEN 3
        END,
        UPPER(u.nome), UPPER(o.nome)
    `;
    
    const result = await query(sql);
    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar defensorias com problemas:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/dashboard/distribuicao - Distribuição de defensorias por regional
router.get('/dashboard/distribuicao', async (req, res) => {
  try {
    const sql = `
      SELECT 
        r.nome as regional,
        r.numero,
        COUNT(o.id) as total_defensorias,
        COUNT(CASE WHEN o.vaga = true THEN 1 END) as vagas,
        COUNT(CASE WHEN o.titular_afastado = true THEN 1 END) as afastados,
        COUNT(CASE WHEN o.vaga = false AND o.titular_afastado = false THEN 1 END) as normais
      FROM regionais r
      LEFT JOIN unidades u ON r.id = u.regional_id
      LEFT JOIN orgaos o ON u.id = o.unidade_id
      GROUP BY r.id, r.nome, r.numero
      ORDER BY r.numero
    `;
    
    const result = await query(sql);
    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar distribuição:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINTS DE COORDENAÇÕES
// =========================

// GET /api/coordenacoes/:unidadeId - Buscar coordenações de uma unidade
router.get('/coordenacoes/:unidadeId', async (req, res) => {
  try {
    const { unidadeId } = req.params;
    
    const sql = `
      SELECT 
        c.id,
        c.tipo_coordenacao,
        c.nome_coordenador,
        c.email_coordenador,
        c.ativo,
        c.created_at,
        c.updated_at
      FROM coordenacoes c
      WHERE c.unidade_id = $1
      ORDER BY 
        CASE c.tipo_coordenacao 
          WHEN 'ADMINISTRATIVA' THEN 1
          WHEN 'CIVEL' THEN 2
          WHEN 'CRIMINAL' THEN 3
          ELSE 4
        END
    `;
    
    const result = await query(sql, [unidadeId]);
    res.json(result.rows);
    
  } catch (error) {
    console.error('Erro ao buscar coordenações:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/coordenacao/:id - Buscar coordenação específica por ID
router.get('/coordenacao/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const sql = `
      SELECT 
        c.id,
        c.unidade_id,
        c.tipo_coordenacao,
        c.nome_coordenador,
        c.email_coordenador,
        c.ativo,
        c.created_at,
        c.updated_at,
        u.nome as unidade_nome
      FROM coordenacoes c
      LEFT JOIN unidades u ON c.unidade_id = u.id
      WHERE c.id = $1
    `;
    
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Coordenação não encontrada' });
    }
    
    res.json(result.rows[0]);
    
  } catch (error) {
    console.error('Erro ao buscar coordenação:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// POST /api/coordenacoes - Criar nova coordenação
router.post('/coordenacoes', async (req, res) => {
  try {
    const { 
      unidade_id, 
      tipo_coordenacao, 
      nome_coordenador, 
      email_coordenador 
    } = req.body;

    // Validações básicas
    if (!unidade_id || !tipo_coordenacao || !nome_coordenador) {
      return res.status(400).json({ 
        error: 'Unidade, tipo de coordenação e nome do coordenador são obrigatórios' 
      });
    }

    // Verificar se já existe coordenação deste tipo para a unidade
    const existingSql = `
      SELECT id FROM coordenacoes 
      WHERE unidade_id = $1 AND tipo_coordenacao = $2 AND ativo = true
    `;
    const existing = await query(existingSql, [unidade_id, tipo_coordenacao]);
    
    if (existing.rows.length > 0) {
      return res.status(400).json({ 
        error: 'Já existe uma coordenação ativa deste tipo para esta unidade' 
      });
    }

    const sql = `
      INSERT INTO coordenacoes (
        unidade_id, tipo_coordenacao, nome_coordenador, email_coordenador
      ) VALUES ($1, $2, $3, $4)
      RETURNING *
    `;

    const params = [
      unidade_id, 
      tipo_coordenacao, 
      nome_coordenador, 
      email_coordenador || null
    ];

    const result = await query(sql, params);
    
    res.status(201).json({
      success: true,
      message: 'Coordenação criada com sucesso',
      coordenacao: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao criar coordenação:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// PUT /api/coordenacoes/:id - Atualizar coordenação
router.put('/coordenacoes/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { 
      tipo_coordenacao, 
      nome_coordenador, 
      email_coordenador,
      ativo 
    } = req.body;

    // Validações básicas
    if (!tipo_coordenacao || !nome_coordenador) {
      return res.status(400).json({ 
        error: 'Tipo de coordenação e nome do coordenador são obrigatórios' 
      });
    }

    const sql = `
      UPDATE coordenacoes SET 
        tipo_coordenacao = $1, 
        nome_coordenador = $2, 
        email_coordenador = $3,
        ativo = $4,
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $5
      RETURNING *
    `;

    const params = [
      tipo_coordenacao, 
      nome_coordenador, 
      email_coordenador || null,
      ativo !== undefined ? ativo : true,
      id
    ];

    const result = await query(sql, params);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Coordenação não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Coordenação atualizada com sucesso',
      coordenacao: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao atualizar coordenação:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// DELETE /api/coordenacoes/:id - Excluir coordenação (soft delete)
router.delete('/coordenacoes/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const sql = `
      UPDATE coordenacoes SET 
        ativo = false,
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $1
      RETURNING *
    `;
    
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Coordenação não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Coordenação excluída com sucesso'
    });
    
  } catch (error) {
    console.error('Erro ao excluir coordenação:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// =========================
// ENDPOINTS DE REGIONAIS
// =========================

// GET /api/regionais - Listar todas as regionais
router.get('/regionais', async (req, res) => {
  try {
    const sql = `
      SELECT 
        r.id,
        r.nome,
        r.numero,
        COUNT(DISTINCT u.id) as total_unidades,
        COUNT(o.id) as total_defensorias,
        COUNT(CASE WHEN o.vaga = true THEN 1 END) as defensorias_vagas,
        COUNT(CASE WHEN o.titular_afastado = true THEN 1 END) as titulares_afastados
      FROM regionais r
      LEFT JOIN unidades u ON r.id = u.regional_id
      LEFT JOIN orgaos o ON u.id = o.unidade_id
      GROUP BY r.id, r.nome, r.numero
      ORDER BY r.numero
    `;
    
    const result = await query(sql);
    res.json(result.rows);
    
  } catch (error) {
    console.error('Erro ao listar regionais:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// GET /api/regionais/:id - Buscar regional específica
router.get('/regionais/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const sql = `
      SELECT 
        r.id,
        r.nome,
        r.numero,
        COUNT(DISTINCT u.id) as total_unidades,
        COUNT(o.id) as total_defensorias,
        COUNT(CASE WHEN o.vaga = true THEN 1 END) as defensorias_vagas,
        COUNT(CASE WHEN o.titular_afastado = true THEN 1 END) as titulares_afastados
      FROM regionais r
      LEFT JOIN unidades u ON r.id = u.regional_id
      LEFT JOIN orgaos o ON u.id = o.unidade_id
      WHERE r.id = $1
      GROUP BY r.id, r.nome, r.numero
    `;
    
    const result = await query(sql, [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Regional não encontrada' });
    }
    
    res.json(result.rows[0]);
    
  } catch (error) {
    console.error('Erro ao buscar regional:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// POST /api/regionais - Criar nova regional
router.post('/regionais', async (req, res) => {
  try {
    const { nome, numero } = req.body;
    
    // Validações básicas
    if (!nome || !numero) {
      return res.status(400).json({ 
        error: 'Nome e número da regional são obrigatórios' 
      });
    }
    
    // Verificar se já existe uma regional com o mesmo número
    const checkSql = 'SELECT id FROM regionais WHERE numero = $1';
    const checkResult = await query(checkSql, [numero]);
    
    if (checkResult.rows.length > 0) {
      return res.status(400).json({ 
        error: 'Já existe uma regional com este número' 
      });
    }
    
    const sql = `
      INSERT INTO regionais (nome, numero) 
      VALUES ($1, $2) 
      RETURNING *
    `;
    
    const result = await query(sql, [nome, numero]);
    res.status(201).json({
      success: true,
      message: 'Regional criada com sucesso',
      regional: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao criar regional:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// PUT /api/regionais/:id - Atualizar regional
router.put('/regionais/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { nome, numero } = req.body;
    
    // Validações básicas
    if (!nome || !numero) {
      return res.status(400).json({ 
        error: 'Nome e número da regional são obrigatórios' 
      });
    }
    
    // Verificar se já existe outra regional com o mesmo número
    const checkSql = 'SELECT id FROM regionais WHERE numero = $1 AND id != $2';
    const checkResult = await query(checkSql, [numero, id]);
    
    if (checkResult.rows.length > 0) {
      return res.status(400).json({ 
        error: 'Já existe outra regional com este número' 
      });
    }
    
    const sql = `
      UPDATE regionais SET 
        nome = $1, 
        numero = $2
      WHERE id = $3
      RETURNING *
    `;
    
    const result = await query(sql, [nome, numero, id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Regional não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Regional atualizada com sucesso',
      regional: result.rows[0]
    });
    
  } catch (error) {
    console.error('Erro ao atualizar regional:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// DELETE /api/regionais/:id - Excluir regional
router.delete('/regionais/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    // Verificar se a regional tem unidades associadas
    const checkSql = 'SELECT COUNT(*) as count FROM unidades WHERE regional_id = $1';
    const checkResult = await query(checkSql, [id]);
    
    if (parseInt(checkResult.rows[0].count) > 0) {
      return res.status(400).json({ 
        error: 'Não é possível excluir uma regional que possui unidades associadas' 
      });
    }
    
    const sql = 'DELETE FROM regionais WHERE id = $1';
    const result = await query(sql, [id]);
    
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Regional não encontrada' });
    }
    
    res.json({
      success: true,
      message: 'Regional excluída com sucesso'
    });
    
  } catch (error) {
    console.error('Erro ao excluir regional:', error);
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

module.exports = router;
