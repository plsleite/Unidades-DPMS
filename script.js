/* =========================
   FUNÇÃO DE NORMALIZAÇÃO
========================= */
function normalizeText(text) {
  return text
    .normalize("NFD")                // separa acentos
    .replace(/[\u0300-\u036f]/g, "") // remove acentos
    .toLowerCase();
}

/* =========================
   VARIÁVEIS GLOBAIS
========================= */
let unidades = []; // Array vazio - será preenchido pela API
let regionais = []; // Array vazio - será preenchido pela API
let isLoading = false;

/* =========================
   FUNÇÕES DE API
========================= */

// Função para buscar dados da API
async function fetchData() {
  try {
    isLoading = true;
    showLoading(true);
    
    // Buscar unidades completas (com órgãos)
    const response = await fetch('/api/unidades-completas');
    
    if (!response.ok) {
      throw new Error(`Erro HTTP: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Transformar dados da API para o formato esperado pelo frontend
    unidades = data.map(unidade => ({
      id: unidade.id,
      nome: unidade.nome,
      endereco: unidade.endereco,
      telefone: unidade.telefone,
      campoGrande: unidade.coordenador !== null, // Campo Grande tem coordenador
      regional: {
        id: unidade.regional_id,
        nome: unidade.regional_nome,
        numero: unidade.regional_numero
      },
      coordenador: unidade.coordenador,
      emailCoordenador: unidade.email_coordenador,
      supervisor: unidade.supervisor,
      emailSupervisor: unidade.email_supervisor,
      orgaos: unidade.orgaos.map(orgao => ({
        id: orgao.id,
        nome: orgao.nome,
        titular: {
          nome: orgao.titular_nome || "Vaga",
          email: orgao.titular_email,
          afastado: orgao.titular_afastado || false,
          vaga: orgao.vaga || false
        },
        substituto: orgao.substituto_nome ? {
          nome: orgao.substituto_nome,
          email: orgao.substituto_email
        } : null
      }))
    }));
    
    // Buscar regionais
    const regionaisResponse = await fetch('/api/regionais');
    if (regionaisResponse.ok) {
      regionais = await regionaisResponse.json();
    }
    
    console.log('✅ Dados carregados da API:', unidades.length, 'unidades');
    
  } catch (error) {
    console.error('❌ Erro ao carregar dados:', error);
    showError('Erro ao carregar dados. Verifique se o servidor está rodando.');
  } finally {
    isLoading = false;
    showLoading(false);
  }
}

// Função para mostrar loading
function showLoading(show) {
  const container = document.getElementById("unitList");
  if (show) {
    container.innerHTML = '<div class="loading">🔄 Carregando dados...</div>';
  }
}

// Função para mostrar erro
function showError(message) {
  const container = document.getElementById("unitList");
  container.innerHTML = `<div class="error">❌ ${message}</div>`;
}

/* =========================
   RENDER
========================= */
function createUnitCard(unidade) {
  let card = `
    <div class="unit">
      <div class="unit-header">${unidade.nome}</div>
      <div class="unit-body">
        <p><strong>Endereço:</strong> ${unidade.endereco}</p>
        <p><strong>Telefone:</strong> ${unidade.telefone}</p>
        ${unidade.regional ? `<p><strong>Regional:</strong> ${unidade.regional.nome}</p>` : ''}
        ${unidade.coordenador ? `<p><strong>Coordenador:</strong> ${unidade.coordenador}</p>` : ''}
        ${unidade.supervisor ? `<p><strong>Supervisor:</strong> ${unidade.supervisor}</p>` : ''}
      </div>
      <div class="unit-extra">
  `;

  unidade.orgaos.forEach(orgao => {
    card += `
      <div class="orgao">
        <p><strong>${orgao.nome}</strong></p>
        <p><strong>Titular:</strong> 
          ${orgao.titular.nome === "Vaga" ? '<span class="vaga">Vaga</span>' : orgao.titular.nome}
          ${orgao.titular.afastado ? ' <span class="afastado">Afastado</span>' : ""}
        </p>
    `;

    if (orgao.titular.email) {
      card += `<p><strong>E-mail:</strong> ${orgao.titular.email}</p>`;
    }

    if (orgao.substituto) {
      card += `
        <p><strong>Em substituição:</strong> ${orgao.substituto.nome}</p>
        <p><strong>E-mail:</strong> ${orgao.substituto.email}</p>
      `;
    }

    card += `</div>`;
  });

  card += `</div></div>`;
  return card;
}

function displayUnits(filteredUnits = unidades, message = "") {
  const container = document.getElementById("unitList");
  container.innerHTML = "";

  if (message) {
    container.innerHTML = `<p class="search-message">${message}</p>`;
  }

  if (!filteredUnits || filteredUnits.length === 0) {
    container.innerHTML += "<p>Nenhuma unidade encontrada.</p>";
    return;
  }

  filteredUnits.forEach(unidade => {
    container.innerHTML += createUnitCard(unidade);
  });
}

/* =========================
   BUSCA + FILTROS
========================= */
function searchUnit() {
  if (isLoading) return; // Não executar se ainda estiver carregando
  
  const rawInput = document.getElementById("searchInput").value.trim();
  const query = normalizeText(rawInput);
  const selectedFilter = document.querySelector("input[name='filter']:checked").value;

  let filtered = unidades;

  // filtro de texto
  if (query) {
    filtered = unidades
      .map(u => {
        const orgaosFiltrados = u.orgaos.filter(o =>
          normalizeText(u.nome).includes(query) ||
          normalizeText(o.nome).includes(query) ||
          (o.titular && (
            normalizeText(o.titular.nome).includes(query) ||
            (o.titular.email && normalizeText(o.titular.email).includes(query))
          )) ||
          (o.substituto && (
            normalizeText(o.substituto.nome).includes(query) ||
            (o.substituto.email && normalizeText(o.substituto.email).includes(query))
          ))
        );
        return { ...u, orgaos: orgaosFiltrados };
      })
      .filter(u => u.orgaos.length > 0 || normalizeText(u.nome).includes(query));
  }

  // filtro especial
  if (selectedFilter === "vagos") {
    filtered = filtered
      .map(u => ({ ...u, orgaos: u.orgaos.filter(o => o.titular.vaga === true) }))
      .filter(u => u.orgaos.length > 0);
    displayUnits(filtered, "🔎 Exibindo apenas órgãos vagos.");

  } else if (selectedFilter === "afastados") {
    filtered = filtered
      .map(u => ({ ...u, orgaos: u.orgaos.filter(o => o.titular.afastado === true) }))
      .filter(u => u.orgaos.length > 0);
    displayUnits(filtered, "🔎 Exibindo apenas órgãos com titulares afastados.");

  } else {
    displayUnits(filtered);
  }
}

/* =========================
   INIT
========================= */
window.onload = async () => {
  console.log('🚀 Iniciando aplicação...');
  
  // Carregar dados da API
  await fetchData();
  
  // Exibir unidades carregadas
  displayUnits(unidades);
  
  console.log('✅ Aplicação iniciada com sucesso!');
};