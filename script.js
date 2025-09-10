/* =========================
   FUNÇÃO DE NORMALIZAÇÃO
========================= */
function normalizeText(text) {
  if (!text || typeof text !== 'string') {
    return '';
  }
  return text
    .normalize("NFD")                // separa acentos
    .replace(/[\u0300-\u036f]/g, "") // remove acentos
    .toLowerCase();
}

/* =========================
   VARIÁVEIS GLOBAIS
========================= */
const API_BASE_URL = 'http://localhost:3000/api';
let unidades = []; // Array vazio - será preenchido pela API
let regionais = []; // Array vazio - será preenchido pela API
let isLoading = false;
let currentAdmin = null; // Dados do administrador logado
let selectedRegionais = []; // Array para armazenar regionais selecionadas

// Dados originais para busca
let originalRegionais = [];
let originalUnidades = [];
let originalOrgaos = [];

/* =========================
   FUNÇÕES DE API
========================= */

// Função para buscar dados da API
async function fetchData() {
  try {
    isLoading = true;
    showLoading(true);
    
    // Buscar unidades completas (com defensorias)
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
      coordenacoes: unidade.coordenacoes || [],
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
      // Carregar chips das regionais
      loadRegionalChips();
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
      <div class="unit-header" onclick="toggleUnitCollapse(${unidade.id})" style="cursor: pointer;">
        <span class="unit-name">${unidade.nome}</span>
        <span class="collapse-icon" id="icon-${unidade.id}">▼</span>
      </div>
      <div class="unit-body" id="body-${unidade.id}">
        <p><strong>Endereço:</strong> ${unidade.endereco}</p>
        <p><strong>Telefone:</strong> ${unidade.telefone}</p>
        ${unidade.regional && unidade.nome !== 'CAMPO GRANDE | 2ª INSTÂNCIA' ? `<p><strong>Regional:</strong> ${unidade.regional.nome}</p>` : ''}
        ${unidade.coordenador && unidade.coordenador.trim() !== '' ? `<p><strong>Coordenação:</strong> ${unidade.coordenador}</p>` : ''}
        ${unidade.supervisor && unidade.supervisor.trim() !== '' ? `<p><strong>Supervisão:</strong> ${unidade.supervisor}</p>` : ''}
        
        <!-- Coordenações de Segunda Instância -->
        ${unidade.coordenacoes && unidade.coordenacoes.length > 0 ? unidade.coordenacoes.map(coordenacao => {
          // Capitalizar a primeira letra de cada palavra
          const tipoCapitalizado = coordenacao.tipo_coordenacao.charAt(0).toUpperCase() + 
                                 coordenacao.tipo_coordenacao.slice(1).toLowerCase();
          return `<p><strong>Coordenação ${tipoCapitalizado}:</strong> ${coordenacao.nome_coordenador}${coordenacao.email_coordenador ? ` (${coordenacao.email_coordenador})` : ''}</p>`;
        }).join('') : ''}
      </div>
      <div class="unit-extra" id="extra-${unidade.id}">
  `;

  unidade.orgaos.forEach(orgao => {
    const isVaga = orgao.titular.nome === "Vaga";
    
    card += `
      <div class="orgao">
        <p><strong>${orgao.nome}${isVaga ? ' <span class="vaga">Defensoria Vaga</span>' : ''}</strong></p>
    `;

    if (!isVaga) {
      card += `<p><strong>Titular:</strong> ${orgao.titular.nome}${orgao.titular.afastado ? ' <span class="afastado">Afastado das Funções</span>' : ""}</p>`;
      
      if (orgao.titular.email) {
        card += `<p><strong>E-mail:</strong> ${orgao.titular.email}</p>`;
      }
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

  // Ordenar unidades por nome normalizado (sem acentos)
  const sortedUnits = [...filteredUnits].sort((a, b) => {
    const nomeA = normalizeText(a.nome);
    const nomeB = normalizeText(b.nome);
    return nomeA.localeCompare(nomeB);
  });

  sortedUnits.forEach(unidade => {
    container.innerHTML += createUnitCard(unidade);
  });
}

/* =========================
   FILTROS POR REGIONAL
========================= */

// Função para carregar chips das regionais
function loadRegionalChips() {
  const container = document.getElementById('regionalChips');
  if (!container || !regionais.length) return;

  container.innerHTML = '';

  regionais.forEach(regional => {
    const chip = document.createElement('div');
    chip.className = 'regional-chip';
    chip.innerHTML = `
      <input type="checkbox" id="regional_${regional.id}" value="${regional.id}">
      <span class="chip-text">${regional.nome}</span>
    `;
    
    // Adicionar evento de clique em todo o chip
    chip.addEventListener('click', (e) => {
      e.preventDefault();
      toggleRegional(regional.id);
    });
    
    container.appendChild(chip);
  });
}

// Função para alternar visibilidade dos filtros por regional
function toggleRegionalFilters() {
  const chipsContainer = document.getElementById('regionalChips');
  const toggleCheckbox = document.getElementById('toggleRegionalCheckbox');
  const toggleText = document.getElementById('toggleRegionalText');
  
  if (!chipsContainer || !toggleCheckbox || !toggleText) return;

  if (toggleCheckbox.checked) {
    // Mostrar filtros
    chipsContainer.style.display = 'flex';
    toggleText.textContent = 'Filtrar por Regional';
  } else {
    // Ocultar filtros e limpar seleções
    chipsContainer.style.display = 'none';
    clearRegionalFilters();
    toggleText.textContent = 'Filtrar por Regional';
  }
}

// Função para alternar seleção de regional
function toggleRegional(regionalId) {
  const checkbox = document.getElementById(`regional_${regionalId}`);
  const chip = checkbox.closest('.regional-chip');
  
  // Alternar o estado do checkbox
  checkbox.checked = !checkbox.checked;
  
  if (checkbox.checked) {
    selectedRegionais.push(regionalId);
    chip.classList.add('selected');
  } else {
    selectedRegionais = selectedRegionais.filter(id => id !== regionalId);
    chip.classList.remove('selected');
  }
  
  // Aplicar filtros
  searchUnit();
}

// Função para limpar seleção de regionais
function clearRegionalFilters() {
  selectedRegionais = [];
  document.querySelectorAll('.regional-chip').forEach(chip => {
    chip.classList.remove('selected');
    const checkbox = chip.querySelector('input[type="checkbox"]');
    if (checkbox) checkbox.checked = false;
  });

  // Desmarcar checkbox principal
  const toggleCheckbox = document.getElementById('toggleRegionalCheckbox');
  if (toggleCheckbox) toggleCheckbox.checked = false;

  // Aplicar filtros
  searchUnit();
}


/* =========================
   BUSCA + FILTROS
========================= */
function searchUnit() {
  if (isLoading) return; // Não executar se ainda estiver carregando
  
  const searchInput = document.getElementById("searchInput");
  if (!searchInput) return; // Não executar se o elemento não existir
  
  const rawInput = searchInput.value.trim();
  const query = normalizeText(rawInput);
  const selectedFilter = document.querySelector("input[name='filter']:checked").value;

  let filtered = unidades;

  // filtro por regionais selecionadas
  if (selectedRegionais.length > 0) {
    filtered = filtered.filter(u => selectedRegionais.includes(u.regional.id));
  }

  // filtro de texto
  if (query) {
    filtered = filtered
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
    
    displayUnits(filtered, "");

  } else if (selectedFilter === "afastados") {
    filtered = filtered
      .map(u => ({ ...u, orgaos: u.orgaos.filter(o => o.titular.afastado === true) }))
      .filter(u => u.orgaos.length > 0);
    
    displayUnits(filtered, "");

  } else {
    displayUnits(filtered, "");
  }
}

/* =========================
   FUNÇÕES DE AUTENTICAÇÃO
========================= */

// Função para fazer login
async function login(username, password) {
  try {
    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password })
    });

    const data = await response.json();

    if (data.success) {
      console.log('✅ Login realizado com sucesso:', data.admin);
      return { 
        success: true, 
        admin: data.admin, 
        token: data.token 
      };
    } else {
      return { success: false, error: data.error };
    }
  } catch (error) {
    console.error('❌ Erro no login:', error);
    return { success: false, error: 'Erro de conexão' };
  }
}

// Função para fazer logout
async function logout() {
  try {
    const token = localStorage.getItem('adminToken');
    if (token) {
      await fetch(`${API_BASE_URL}/auth/logout`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
    }
  } catch (error) {
    console.error('Erro no logout:', error);
  } finally {
    // Limpar dados locais
    localStorage.removeItem('adminToken');
    currentAdmin = null;
    updateAdminUI();
    
    // Recarregar dados da área pública após logout
    fetchData().then(() => {
      displayUnits();
    }).catch(error => {
      console.error('Erro ao recarregar dados:', error);
    });
    
    console.log('✅ Logout realizado');
  }
}

// Função para verificar se está logado
async function checkAuth() {
  const token = localStorage.getItem('adminToken');
  console.log('🔍 Verificando autenticação, token:', token ? 'existe' : 'não existe');
  
  if (token) {
    try {
      const response = await fetch(`${API_BASE_URL}/auth/me`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      console.log('🔍 Resposta da verificação:', response.status);
      
      if (response.ok) {
        const result = await response.json();
        console.log('✅ Token válido, admin:', result.admin);
        currentAdmin = result.admin;
        updateAdminUI();
        return true;
      } else {
        console.log('❌ Token inválido, removendo do localStorage');
        // Token inválido, remover do localStorage
        localStorage.removeItem('adminToken');
        currentAdmin = null;
        updateAdminUI();
        return false;
      }
    } catch (error) {
      console.error('❌ Erro ao verificar autenticação:', error);
      localStorage.removeItem('adminToken');
      currentAdmin = null;
      updateAdminUI();
      return false;
    }
  }
  console.log('❌ Nenhum token encontrado');
  return false;
}


// Função para abrir modal de login
function toggleLoginModal() {
  const modal = document.getElementById('loginModal');
  modal.style.display = 'block';
  document.getElementById('username').focus();
}

// Função para fechar modal de login
function closeLoginModal() {
  const modal = document.getElementById('loginModal');
  modal.style.display = 'none';
  document.getElementById('loginForm').reset();
  hideLoginError();
}

// Função para mostrar erro de login
function showLoginError(message) {
  const errorDiv = document.getElementById('loginError');
  errorDiv.textContent = message;
  errorDiv.style.display = 'block';
}

// Função para esconder erro de login
function hideLoginError() {
  const errorDiv = document.getElementById('loginError');
  errorDiv.style.display = 'none';
}

// Função para processar formulário de login
async function handleLogin(event) {
  event.preventDefault();
  
  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;
  const loginBtn = document.querySelector('.btn-login');
  
  // Desabilitar botão durante login
  loginBtn.disabled = true;
  loginBtn.textContent = 'Entrando...';
  
  try {
    const result = await login(username, password);
    
    if (result.success) {
      console.log('✅ Login bem-sucedido, result:', result);
      currentAdmin = result.admin;
      localStorage.setItem('adminToken', result.token);
      closeLoginModal();
      console.log('🔄 Chamando updateAdminUI...');
      updateAdminUI();
    } else {
      console.log('❌ Login falhou:', result.error);
      showLoginError(result.error || 'Erro no login');
    }
  } catch (error) {
    showLoginError('Erro de conexão');
  } finally {
    // Reabilitar botão
    loginBtn.disabled = false;
    loginBtn.textContent = 'Entrar';
  }
}

/* =========================
   ÁREA ADMINISTRATIVA
========================= */

// Função para atualizar a UI do admin
function updateAdminUI() {
  console.log('🔄 updateAdminUI chamada, currentAdmin:', currentAdmin);
  
  const adminBtn = document.getElementById('adminBtn');
  const adminArea = document.getElementById('adminArea');
  const container = document.querySelector('.container');
  const adminWelcome = document.getElementById('adminWelcome');
  
  console.log('🔍 Elementos encontrados:', {
    adminBtn: !!adminBtn,
    adminArea: !!adminArea,
    container: !!container,
    adminWelcome: !!adminWelcome
  });
  
  if (currentAdmin) {
    console.log('✅ Admin logado, mostrando área administrativa');
    console.log('🔍 currentAdmin.username:', currentAdmin.username);
    if (adminBtn) adminBtn.style.display = 'none'; // Esconder botão admin na área administrativa
    if (adminArea) {
      console.log('🔍 Mostrando adminArea');
      adminArea.style.display = 'block';
    }
    if (container) {
      console.log('🔍 Escondendo container');
      container.style.display = 'none';
    }
    if (adminWelcome) adminWelcome.textContent = `Bem-vindo, ${currentAdmin.username}!`;
    
    // Carregar dados administrativos
    loadAdminData();
  } else {
    console.log('❌ Nenhum admin logado, mostrando área pública');
    if (adminBtn) {
      adminBtn.textContent = '🔐 Área Administrativa';
      adminBtn.onclick = toggleLoginModal;
      adminBtn.style.display = 'block'; // Mostrar botão admin na área pública
    }
    if (adminArea) adminArea.style.display = 'none';
    if (container) container.style.display = 'block';
  }
}

// Carregar dados para o dashboard administrativo
async function loadAdminData() {
  try {
    // Carregar estatísticas do dashboard
    await loadDashboardStats();
    
    // Carregar listas de unidades e defensorias
    await loadUnidadesList();
    await loadOrgaosList();
  } catch (error) {
    console.error('Erro ao carregar dados administrativos:', error);
  }
}

// Carregar estatísticas do dashboard
async function loadDashboardStats() {
  try {
    const response = await fetch(`${API_BASE_URL}/unidades-completas`);
    const unidadesData = await response.json();
    
    const totalUnidades = unidadesData.length;
    let totalOrgaos = 0;
    let orgaosVagos = 0;
    let titularesAfastados = 0;
    
    unidadesData.forEach(unidade => {
      totalOrgaos += unidade.orgaos.length;
      unidade.orgaos.forEach(orgao => {
        if (orgao.vaga) orgaosVagos++;
        if (orgao.titular_afastado) titularesAfastados++;
      });
    });
    
    document.getElementById('totalUnidades').textContent = totalUnidades;
    document.getElementById('totalOrgaos').textContent = totalOrgaos;
    document.getElementById('orgaosVagos').textContent = orgaosVagos;
    document.getElementById('titularesAfastados').textContent = titularesAfastados;
  } catch (error) {
    console.error('Erro ao carregar estatísticas:', error);
  }
}

// Carregar lista de unidades para administração
async function loadUnidadesList() {
  try {
    const response = await fetch(`${API_BASE_URL}/unidades-completas`);
    const unidadesData = await response.json();
    
    unidades = unidadesData;
    originalUnidades = [...unidadesData];
    renderUnidadesList(unidades);
  } catch (error) {
    console.error('Erro ao carregar unidades:', error);
  }
}

// Função para renderizar lista de unidades
function renderUnidadesList(unidadesData) {
  const unidadesList = document.getElementById('unidadesList');
  unidadesList.innerHTML = '';
  
  unidadesData.forEach(unidade => {
    const unidadeDiv = document.createElement('div');
    unidadeDiv.className = 'admin-item';
    unidadeDiv.innerHTML = `
      <div class="admin-item-info">
        <h4>${unidade.nome}</h4>
        <p>${unidade.endereco}${unidade.nome !== 'CAMPO GRANDE | 2ª INSTÂNCIA' ? ` • ${unidade.regional_nome || 'Sem regional'}` : ''}</p>
        <p>Coordenação: ${unidade.coordenador || 'Não informado'}</p>
      </div>
      <div class="admin-item-actions">
        <button class="btn-edit" onclick="editUnidade(${unidade.id})">Editar</button>
        <button class="btn-delete" onclick="deleteUnidade(${unidade.id})">Excluir</button>
      </div>
    `;
    unidadesList.appendChild(unidadeDiv);
  });
}

// Carregar lista de defensorias para administração
async function loadOrgaosList() {
  try {
    const response = await fetch(`${API_BASE_URL}/orgaos`);
    const orgaosData = await response.json();
    
    orgaos = orgaosData;
    originalOrgaos = [...orgaosData];
    renderOrgaosList(orgaos);
  } catch (error) {
    console.error('Erro ao carregar defensorias:', error);
  }
}

// Função para renderizar lista de defensorias
function renderOrgaosList(orgaosData) {
  const orgaosList = document.getElementById('orgaosList');
  orgaosList.innerHTML = '';
  
  orgaosData.forEach(orgao => {
    const orgaoDiv = document.createElement('div');
    orgaoDiv.className = 'admin-item';
    orgaoDiv.innerHTML = `
      <div class="admin-item-info">
        <h4>${orgao.nome}</h4>
        <p>Unidade: ${orgao.unidade_nome || 'Não informada'}</p>
        <p>Titular: ${orgao.titular_nome || 'Não informado'}</p>
        <p>Status: ${orgao.vaga ? 'Vago' : (orgao.titular_afastado ? 'Titular afastado' : 'Ativo')}</p>
      </div>
      <div class="admin-item-actions">
        <button class="btn-edit" onclick="editOrgao(${orgao.id})">Editar</button>
        <button class="btn-delete" onclick="deleteOrgao(${orgao.id})">Excluir</button>
      </div>
    `;
    orgaosList.appendChild(orgaoDiv);
  });
}

// Funções de navegação entre abas
function showAdminTab(tabName) {
  // Remover classe active de todas as abas e conteúdos
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
  document.querySelectorAll('.admin-tab-content').forEach(content => content.classList.remove('active'));
  
  // Ativar aba e conteúdo selecionados
  event.target.classList.add('active');
  document.getElementById(`admin${tabName.charAt(0).toUpperCase() + tabName.slice(1)}`).classList.add('active');
  
  // Carregar dados específicos da aba
  if (tabName === 'dashboard') {
    loadDashboardData();
  } else if (tabName === 'unidades') {
    loadUnidadesList();
    // Configurar eventos de busca após o DOM estar pronto
    setTimeout(() => {
      setupSearchEvents();
    }, 100);
  } else if (tabName === 'orgaos') {
    loadOrgaosList();
    setTimeout(() => {
      setupSearchEvents();
    }, 100);
  } else if (tabName === 'regionais') {
    loadRegionaisList();
    setTimeout(() => {
      setupSearchEvents();
    }, 100);
  }
}

// Funções de modal de unidade
function openUnidadeModal(unidadeId = null) {
  const modal = document.getElementById('unidadeModal');
  const title = document.getElementById('unidadeModalTitle');
  const form = document.getElementById('unidadeForm');
  
  if (unidadeId) {
    title.textContent = 'Editar Unidade';
    // Carregar dados da unidade para edição
    loadUnidadeData(unidadeId);
  } else {
    title.textContent = 'Nova Unidade';
    form.reset();
    // Limpar campos condicionais
    document.getElementById('coordenadorFields').style.display = 'none';
    document.getElementById('supervisorFields').style.display = 'none';
    document.getElementById('coordenacoesSegundaInstancia').style.display = 'none';
    
    // Mostrar campo de regional para nova unidade
    document.getElementById('unidadeRegional').style.display = 'block';
    document.querySelector('label[for="unidadeRegional"]').style.display = 'block';
    
    // Mostrar seções de coordenador e supervisor para nova unidade
    const coordenadorSection = document.getElementById('unidadeTemCoordenador').parentElement.parentElement.parentElement;
    const supervisorSection = document.getElementById('unidadeTemSupervisor').parentElement.parentElement.parentElement;
    
    coordenadorSection.style.display = 'block';
    supervisorSection.style.display = 'block';
  }
  
  modal.style.display = 'block';
  loadRegionaisForSelect();
}

function closeUnidadeModal() {
  document.getElementById('unidadeModal').style.display = 'none';
}

function loadRegionaisForSelect() {
  // Carregar regionais para o select
  fetch(`${API_BASE_URL}/regionais`)
    .then(response => response.json())
    .then(regionais => {
      const select = document.getElementById('unidadeRegional');
      select.innerHTML = '<option value="">Selecione uma regional</option>';
      regionais.forEach(regional => {
        const option = document.createElement('option');
        option.value = regional.id;
        option.textContent = regional.nome;
        select.appendChild(option);
      });
    });
}

async function loadUnidadeData(unidadeId) {
  try {
    const response = await fetch(`${API_BASE_URL}/unidades/${unidadeId}`);
    const unidade = await response.json();
    
    if (response.ok) {
      // Preencher formulário com dados da unidade
      document.getElementById('unidadeId').value = unidade.id;
      document.getElementById('unidadeNome').value = unidade.nome;
      document.getElementById('unidadeEndereco').value = unidade.endereco;
      document.getElementById('unidadeTelefone').value = unidade.telefone || '';
      
      // Coordenador e Supervisor (ocultar para CAMPO GRANDE | 2ª INSTÂNCIA)
      const isSegundaInstancia = unidade.nome === 'CAMPO GRANDE | 2ª INSTÂNCIA';
      
      // Regional (ocultar para CAMPO GRANDE | 2ª INSTÂNCIA)
      if (isSegundaInstancia) {
        document.getElementById('unidadeRegional').value = '';
        document.getElementById('unidadeRegional').style.display = 'none';
        document.querySelector('label[for="unidadeRegional"]').style.display = 'none';
      } else {
        document.getElementById('unidadeRegional').value = unidade.regional_id || '';
        document.getElementById('unidadeRegional').style.display = 'block';
        document.querySelector('label[for="unidadeRegional"]').style.display = 'block';
      }
      
      if (isSegundaInstancia) {
        // Ocultar seções inteiras de coordenador e supervisor
        const coordenadorSection = document.getElementById('unidadeTemCoordenador').parentElement.parentElement.parentElement;
        const supervisorSection = document.getElementById('unidadeTemSupervisor').parentElement.parentElement.parentElement;
        
        coordenadorSection.style.display = 'none';
        supervisorSection.style.display = 'none';
        document.getElementById('coordenadorFields').style.display = 'none';
        document.getElementById('supervisorFields').style.display = 'none';
        
        // Limpar campos
        document.getElementById('unidadeCoordenador').value = '';
        document.getElementById('unidadeEmailCoordenador').value = '';
        document.getElementById('unidadeSupervisor').value = '';
        document.getElementById('unidadeEmailSupervisor').value = '';
        document.getElementById('unidadeCoordenador').required = false;
        document.getElementById('unidadeEmailCoordenador').required = false;
        document.getElementById('unidadeSupervisor').required = false;
        document.getElementById('unidadeEmailSupervisor').required = false;
      } else {
        // Mostrar seções normalmente para outras unidades
        const coordenadorSection = document.getElementById('unidadeTemCoordenador').parentElement.parentElement.parentElement;
        const supervisorSection = document.getElementById('unidadeTemSupervisor').parentElement.parentElement.parentElement;
        
        coordenadorSection.style.display = 'block';
        supervisorSection.style.display = 'block';
        
        // Coordenador
        const temCoordenador = !!(unidade.coordenador && unidade.email_coordenador);
        document.getElementById('unidadeTemCoordenador').checked = temCoordenador;
        if (temCoordenador) {
          document.getElementById('coordenadorFields').style.display = 'block';
          document.getElementById('unidadeCoordenador').value = unidade.coordenador || '';
          document.getElementById('unidadeEmailCoordenador').value = unidade.email_coordenador || '';
          document.getElementById('unidadeCoordenador').required = true;
          document.getElementById('unidadeEmailCoordenador').required = true;
        } else {
          document.getElementById('coordenadorFields').style.display = 'none';
          document.getElementById('unidadeCoordenador').value = '';
          document.getElementById('unidadeEmailCoordenador').value = '';
          document.getElementById('unidadeCoordenador').required = false;
          document.getElementById('unidadeEmailCoordenador').required = false;
        }
        
        // Supervisor
        const temSupervisor = !!(unidade.supervisor && unidade.email_supervisor);
        document.getElementById('unidadeTemSupervisor').checked = temSupervisor;
        if (temSupervisor) {
          document.getElementById('supervisorFields').style.display = 'block';
          document.getElementById('unidadeSupervisor').value = unidade.supervisor || '';
          document.getElementById('unidadeEmailSupervisor').value = unidade.email_supervisor || '';
          document.getElementById('unidadeSupervisor').required = true;
          document.getElementById('unidadeEmailSupervisor').required = true;
        } else {
          document.getElementById('supervisorFields').style.display = 'none';
          document.getElementById('unidadeSupervisor').value = '';
          document.getElementById('unidadeEmailSupervisor').value = '';
          document.getElementById('unidadeSupervisor').required = false;
          document.getElementById('unidadeEmailSupervisor').required = false;
        }
      }
      
      // Coordenações de Segunda Instância (apenas para CAMPO GRANDE | 2ª INSTÂNCIA)
      const coordenacoesSection = document.getElementById('coordenacoesSegundaInstancia');
      if (unidade.nome === 'CAMPO GRANDE | 2ª INSTÂNCIA') {
        coordenacoesSection.style.display = 'block';
        
        // Carregar coordenações existentes
        if (unidade.coordenacoes && unidade.coordenacoes.length > 0) {
          unidade.coordenacoes.forEach(coordenacao => {
            switch (coordenacao.tipo_coordenacao) {
              case 'ADMINISTRATIVA':
                document.getElementById('coordenacaoAdminNome').value = coordenacao.nome_coordenador || '';
                document.getElementById('coordenacaoAdminEmail').value = coordenacao.email_coordenador || '';
                break;
              case 'CIVEL':
                document.getElementById('coordenacaoCivelNome').value = coordenacao.nome_coordenador || '';
                document.getElementById('coordenacaoCivelEmail').value = coordenacao.email_coordenador || '';
                break;
              case 'CRIMINAL':
                document.getElementById('coordenacaoCriminalNome').value = coordenacao.nome_coordenador || '';
                document.getElementById('coordenacaoCriminalEmail').value = coordenacao.email_coordenador || '';
                break;
            }
          });
        }
      } else {
        coordenacoesSection.style.display = 'none';
        // Limpar campos se não for a unidade de segunda instância
        document.getElementById('coordenacaoAdminNome').value = '';
        document.getElementById('coordenacaoAdminEmail').value = '';
        document.getElementById('coordenacaoCivelNome').value = '';
        document.getElementById('coordenacaoCivelEmail').value = '';
        document.getElementById('coordenacaoCriminalNome').value = '';
        document.getElementById('coordenacaoCriminalEmail').value = '';
      }
    } else {
      console.error('Erro ao carregar unidade:', unidade.error);
      alert('Erro ao carregar dados da unidade');
    }
  } catch (error) {
    console.error('Erro ao carregar unidade:', error);
    alert('Erro ao carregar dados da unidade');
  }
}

function editUnidade(unidadeId) {
  openUnidadeModal(unidadeId);
}

async function deleteUnidade(unidadeId) {
  if (confirm('Tem certeza que deseja excluir esta unidade?')) {
    try {
      const response = await fetch(`${API_BASE_URL}/unidades/${unidadeId}`, {
        method: 'DELETE'
      });
      
      const result = await response.json();
      
      if (response.ok) {
        alert('Unidade excluída com sucesso!');
        loadUnidadesList(); // Recarregar lista
      } else {
        alert(`Erro ao excluir unidade: ${result.error}`);
      }
    } catch (error) {
      console.error('Erro ao excluir unidade:', error);
      alert('Erro ao excluir unidade');
    }
  }
}

// Função para processar formulário de unidade
async function handleUnidadeSubmit(event) {
  event.preventDefault();
  
  const unidadeId = document.getElementById('unidadeId').value;
  const nomeUnidade = document.getElementById('unidadeNome').value;
  const isSegundaInstancia = nomeUnidade === 'CAMPO GRANDE | 2ª INSTÂNCIA';
  
  let formData;
  
  if (isSegundaInstancia) {
    // Para CAMPO GRANDE | 2ª INSTÂNCIA, não incluir coordenador e supervisor
    formData = {
      nome: nomeUnidade,
      endereco: document.getElementById('unidadeEndereco').value,
      telefone: document.getElementById('unidadeTelefone').value,
      regional_id: document.getElementById('unidadeRegional').value || null,
      coordenador: null,
      email_coordenador: null,
      supervisor: null,
      email_supervisor: null
    };
  } else {
    // Para outras unidades, incluir coordenador e supervisor normalmente
    const temCoordenador = document.getElementById('unidadeTemCoordenador').checked;
    const temSupervisor = document.getElementById('unidadeTemSupervisor').checked;
    
    formData = {
      nome: nomeUnidade,
      endereco: document.getElementById('unidadeEndereco').value,
      telefone: document.getElementById('unidadeTelefone').value,
      regional_id: document.getElementById('unidadeRegional').value || null,
      coordenador: temCoordenador ? document.getElementById('unidadeCoordenador').value : null,
      email_coordenador: temCoordenador ? document.getElementById('unidadeEmailCoordenador').value : null,
      supervisor: temSupervisor ? document.getElementById('unidadeSupervisor').value : null,
      email_supervisor: temSupervisor ? document.getElementById('unidadeEmailSupervisor').value : null
    };
  }
  
  // Validações
  if (!formData.nome || !formData.endereco || !formData.telefone || (!isSegundaInstancia && !formData.regional_id)) {
    alert(isSegundaInstancia ? 'Nome, endereço e telefone são obrigatórios' : 'Nome, endereço, telefone e regional são obrigatórios');
    return;
  }
  
  // Validações de coordenador e supervisor (apenas para unidades que não sejam de segunda instância)
  if (!isSegundaInstancia) {
    const temCoordenador = document.getElementById('unidadeTemCoordenador').checked;
    const temSupervisor = document.getElementById('unidadeTemSupervisor').checked;
    
    if (temCoordenador && (!formData.coordenador || !formData.email_coordenador)) {
      alert('Nome e email da coordenação são obrigatórios quando marcado');
      return;
    }
    
    if (temSupervisor && (!formData.supervisor || !formData.email_supervisor)) {
      alert('Nome e email da supervisão são obrigatórios quando marcado');
      return;
    }
  }
  
  // Validações específicas para coordenações de segunda instância
  if (nomeUnidade === 'CAMPO GRANDE | 2ª INSTÂNCIA') {
    const coordenacaoAdminNome = document.getElementById('coordenacaoAdminNome').value;
    const coordenacaoCivelNome = document.getElementById('coordenacaoCivelNome').value;
    const coordenacaoCriminalNome = document.getElementById('coordenacaoCriminalNome').value;
    
    if (!coordenacaoAdminNome || !coordenacaoCivelNome || !coordenacaoCriminalNome) {
      alert('Para a unidade CAMPO GRANDE | 2ª INSTÂNCIA, todos os coordenadores são obrigatórios');
      return;
    }
  }
  
  try {
    const url = unidadeId ? `${API_BASE_URL}/unidades/${unidadeId}` : `${API_BASE_URL}/unidades`;
    const method = unidadeId ? 'PUT' : 'POST';
    
    const response = await fetch(url, {
      method: method,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    });
    
    const result = await response.json();
    
    if (response.ok) {
      // Se for a unidade CAMPO GRANDE | 2ª INSTÂNCIA, salvar/atualizar coordenações
      if (nomeUnidade === 'CAMPO GRANDE | 2ª INSTÂNCIA') {
        await salvarCoordenacoes(unidadeId || result.unidade.id);
      }
      
      alert(result.message);
      closeUnidadeModal();
      loadUnidadesList(); // Recarregar lista
      loadAdminData(); // Recarregar dashboard
    } else {
      alert(`Erro: ${result.error}`);
    }
  } catch (error) {
    console.error('Erro ao salvar unidade:', error);
    alert('Erro ao salvar unidade');
  }
}

// Funções de modal de defensoria
function openOrgaoModal(orgaoId = null) {
  const modal = document.getElementById('orgaoModal');
  const title = document.getElementById('orgaoModalTitle');
  const form = document.getElementById('orgaoForm');
  
  if (orgaoId) {
    title.textContent = 'Editar Defensoria';
    // Carregar dados da defensoria para edição
    loadOrgaoData(orgaoId);
  } else {
    title.textContent = 'Nova Defensoria';
    form.reset();
  }
  
  modal.style.display = 'block';
  loadUnidadesForSelect();
}

function closeOrgaoModal() {
  document.getElementById('orgaoModal').style.display = 'none';
}

function loadUnidadesForSelect() {
  // Carregar unidades para o select
  return fetch(`${API_BASE_URL}/unidades`)
    .then(response => response.json())
    .then(unidades => {
      const select = document.getElementById('orgaoUnidade');
      select.innerHTML = '<option value="">Selecione uma unidade</option>';
      unidades.forEach(unidade => {
        const option = document.createElement('option');
        option.value = unidade.id;
        option.textContent = unidade.nome;
        select.appendChild(option);
      });
    });
}

async function loadOrgaoData(orgaoId) {
  try {
    const response = await fetch(`${API_BASE_URL}/orgaos/${orgaoId}`);
    const orgao = await response.json();
    
    if (response.ok) {
      // Preencher formulário com dados da defensoria
      document.getElementById('orgaoId').value = orgao.id;
      document.getElementById('orgaoNome').value = orgao.nome;
      
      // Aguardar o carregamento das unidades antes de definir o valor
      await loadUnidadesForSelect();
      document.getElementById('orgaoUnidade').value = orgao.unidade_id;
      
      // Defensoria vaga
      const isVaga = orgao.vaga || false;
      document.getElementById('orgaoVaga').checked = isVaga;
      
      if (isVaga) {
        document.getElementById('titularFields').style.display = 'none';
        document.getElementById('substitutoFields').style.display = 'block';
        document.getElementById('orgaoTitularNome').required = false;
        document.getElementById('orgaoTitularEmail').required = false;
        document.getElementById('orgaoSubstitutoNome').required = true;
        document.getElementById('orgaoSubstitutoEmail').required = true;
        document.getElementById('orgaoTitularNome').value = '';
        document.getElementById('orgaoTitularEmail').value = '';
      } else {
        document.getElementById('titularFields').style.display = 'block';
        document.getElementById('orgaoTitularNome').required = true;
        document.getElementById('orgaoTitularEmail').required = true;
      }
      
      // Titular
      document.getElementById('orgaoTitularNome').value = orgao.titular_nome || '';
      document.getElementById('orgaoTitularEmail').value = orgao.titular_email || '';
      document.getElementById('orgaoTitularAfastado').checked = orgao.titular_afastado || false;
      
      // Substituto
      const isTitularAfastado = orgao.titular_afastado || false;
      if (isVaga || isTitularAfastado) {
        document.getElementById('substitutoFields').style.display = 'block';
        document.getElementById('orgaoSubstitutoNome').required = true;
        document.getElementById('orgaoSubstitutoEmail').required = true;
      } else {
        document.getElementById('substitutoFields').style.display = 'none';
        document.getElementById('orgaoSubstitutoNome').required = false;
        document.getElementById('orgaoSubstitutoEmail').required = false;
      }
      
      document.getElementById('orgaoSubstitutoNome').value = orgao.substituto_nome || '';
      document.getElementById('orgaoSubstitutoEmail').value = orgao.substituto_email || '';
    } else {
      console.error('Erro ao carregar defensoria:', orgao.error);
      alert('Erro ao carregar dados da defensoria');
    }
  } catch (error) {
    console.error('Erro ao carregar defensoria:', error);
    alert('Erro ao carregar dados da defensoria');
  }
}

function editOrgao(orgaoId) {
  openOrgaoModal(orgaoId);
}

async function deleteOrgao(orgaoId) {
  if (confirm('Tem certeza que deseja excluir esta defensoria?')) {
    try {
      const response = await fetch(`${API_BASE_URL}/orgaos/${orgaoId}`, {
        method: 'DELETE'
      });
      
      const result = await response.json();
      
      if (response.ok) {
        alert('Defensoria excluída com sucesso!');
        loadOrgaosList(); // Recarregar lista
      } else {
        alert(`Erro ao excluir defensoria: ${result.error}`);
      }
    } catch (error) {
      console.error('Erro ao excluir defensoria:', error);
      alert('Erro ao excluir defensoria');
    }
  }
}

// Função para salvar/atualizar coordenações
async function salvarCoordenacoes(unidadeId) {
  const coordenacoes = [
    {
      tipo: 'ADMINISTRATIVA',
      nome: document.getElementById('coordenacaoAdminNome').value,
      email: document.getElementById('coordenacaoAdminEmail').value
    },
    {
      tipo: 'CIVEL',
      nome: document.getElementById('coordenacaoCivelNome').value,
      email: document.getElementById('coordenacaoCivelEmail').value
    },
    {
      tipo: 'CRIMINAL',
      nome: document.getElementById('coordenacaoCriminalNome').value,
      email: document.getElementById('coordenacaoCriminalEmail').value
    }
  ];
  
  for (const coordenacao of coordenacoes) {
    try {
      // Verificar se já existe coordenação deste tipo
      const existingResponse = await fetch(`${API_BASE_URL}/coordenacoes/${unidadeId}`);
      const existingCoordenacoes = await existingResponse.json();
      
      const existing = existingCoordenacoes.find(c => c.tipo_coordenacao === coordenacao.tipo);
      
      const data = {
        unidade_id: unidadeId,
        tipo_coordenacao: coordenacao.tipo,
        nome_coordenador: coordenacao.nome,
        email_coordenador: coordenacao.email || null
      };
      
      if (existing) {
        // Atualizar coordenação existente
        await fetch(`${API_BASE_URL}/coordenacoes/${existing.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        });
      } else {
        // Criar nova coordenação
        await fetch(`${API_BASE_URL}/coordenacoes`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        });
      }
    } catch (error) {
      console.error(`Erro ao salvar coordenação ${coordenacao.tipo}:`, error);
    }
  }
}

// Função para processar formulário de defensoria
async function handleOrgaoSubmit(event) {
  event.preventDefault();
  
  const orgaoId = document.getElementById('orgaoId').value;
  const isVaga = document.getElementById('orgaoVaga').checked;
  const isTitularAfastado = document.getElementById('orgaoTitularAfastado').checked;
  
  const formData = {
    nome: document.getElementById('orgaoNome').value,
    unidade_id: document.getElementById('orgaoUnidade').value,
    titular_nome: isVaga ? null : document.getElementById('orgaoTitularNome').value,
    titular_email: isVaga ? null : document.getElementById('orgaoTitularEmail').value,
    titular_afastado: isTitularAfastado,
    vaga: isVaga,
    substituto_nome: (isVaga || isTitularAfastado) ? document.getElementById('orgaoSubstitutoNome').value : null,
    substituto_email: (isVaga || isTitularAfastado) ? document.getElementById('orgaoSubstitutoEmail').value : null
  };
  
  // Validações
  if (!formData.nome || !formData.unidade_id) {
    alert('Nome da defensoria e unidade são obrigatórios');
    return;
  }
  
  if (!isVaga && (!formData.titular_nome || !formData.titular_email)) {
    alert('Nome e email do titular são obrigatórios quando a defensoria não está vaga');
    return;
  }
  
  if ((isVaga || isTitularAfastado) && (!formData.substituto_nome || !formData.substituto_email)) {
    alert('Nome e email do substituto são obrigatórios quando a defensoria está vaga ou o titular está afastado');
    return;
  }
  
  try {
    const url = orgaoId ? `${API_BASE_URL}/orgaos/${orgaoId}` : `${API_BASE_URL}/orgaos`;
    const method = orgaoId ? 'PUT' : 'POST';
    
    const response = await fetch(url, {
      method: method,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    });
    
    const result = await response.json();
    
    if (response.ok) {
      alert(result.message);
      closeOrgaoModal();
      loadOrgaosList(); // Recarregar lista
      loadAdminData(); // Recarregar dashboard
    } else {
      alert(`Erro: ${result.error}`);
    }
  } catch (error) {
    console.error('Erro ao salvar defensoria:', error);
    alert('Erro ao salvar defensoria');
  }
}

// Configurar campos condicionais
function setupConditionalFields() {
  // Checkbox de coordenador
  const coordenadorCheckbox = document.getElementById('unidadeTemCoordenador');
  const coordenadorFields = document.getElementById('coordenadorFields');
  
  if (coordenadorCheckbox && coordenadorFields) {
    coordenadorCheckbox.addEventListener('change', function() {
      if (this.checked) {
        coordenadorFields.style.display = 'block';
        document.getElementById('unidadeCoordenador').required = true;
        document.getElementById('unidadeEmailCoordenador').required = true;
      } else {
        coordenadorFields.style.display = 'none';
        document.getElementById('unidadeCoordenador').required = false;
        document.getElementById('unidadeEmailCoordenador').required = false;
        document.getElementById('unidadeCoordenador').value = '';
        document.getElementById('unidadeEmailCoordenador').value = '';
      }
    });
  }
  
  // Checkbox de supervisor
  const supervisorCheckbox = document.getElementById('unidadeTemSupervisor');
  const supervisorFields = document.getElementById('supervisorFields');
  
  if (supervisorCheckbox && supervisorFields) {
    supervisorCheckbox.addEventListener('change', function() {
      if (this.checked) {
        supervisorFields.style.display = 'block';
        document.getElementById('unidadeSupervisor').required = true;
        document.getElementById('unidadeEmailSupervisor').required = true;
      } else {
        supervisorFields.style.display = 'none';
        document.getElementById('unidadeSupervisor').required = false;
        document.getElementById('unidadeEmailSupervisor').required = false;
        document.getElementById('unidadeSupervisor').value = '';
        document.getElementById('unidadeEmailSupervisor').value = '';
      }
    });
  }
  
  // Checkbox de defensoria vaga
  const vagaCheckbox = document.getElementById('orgaoVaga');
  const titularFields = document.getElementById('titularFields');
  const substitutoFields = document.getElementById('substitutoFields');
  
  if (vagaCheckbox && titularFields && substitutoFields) {
    vagaCheckbox.addEventListener('change', function() {
      if (this.checked) {
        titularFields.style.display = 'none';
        substitutoFields.style.display = 'block';
        document.getElementById('orgaoTitularNome').required = false;
        document.getElementById('orgaoTitularEmail').required = false;
        document.getElementById('orgaoSubstitutoNome').required = true;
        document.getElementById('orgaoSubstitutoEmail').required = true;
        document.getElementById('orgaoTitularNome').value = '';
        document.getElementById('orgaoTitularEmail').value = '';
      } else {
        titularFields.style.display = 'block';
        document.getElementById('orgaoTitularNome').required = true;
        document.getElementById('orgaoTitularEmail').required = true;
        checkSubstitutoFields();
      }
    });
  }
  
  // Checkbox de titular afastado
  const afastadoCheckbox = document.getElementById('orgaoTitularAfastado');
  
  if (afastadoCheckbox && substitutoFields) {
    afastadoCheckbox.addEventListener('change', function() {
      checkSubstitutoFields();
    });
  }
}

// Verificar se deve mostrar campos de substituto
function checkSubstitutoFields() {
  const vagaCheckbox = document.getElementById('orgaoVaga');
  const afastadoCheckbox = document.getElementById('orgaoTitularAfastado');
  const substitutoFields = document.getElementById('substitutoFields');
  
  if (vagaCheckbox && afastadoCheckbox && substitutoFields) {
    if (vagaCheckbox.checked || afastadoCheckbox.checked) {
      substitutoFields.style.display = 'block';
      document.getElementById('orgaoSubstitutoNome').required = true;
      document.getElementById('orgaoSubstitutoEmail').required = true;
    } else {
      substitutoFields.style.display = 'none';
      document.getElementById('orgaoSubstitutoNome').required = false;
      document.getElementById('orgaoSubstitutoEmail').required = false;
      document.getElementById('orgaoSubstitutoNome').value = '';
      document.getElementById('orgaoSubstitutoEmail').value = '';
    }
  }
}


/* =========================
   INIT
========================= */
window.onload = async () => {
  console.log('🚀 Iniciando aplicação...');
  
  // Verificar autenticação
  await checkAuth();
  
  // Configurar formulário de login
  document.getElementById('loginForm').addEventListener('submit', handleLogin);
  
  // Configurar formulário de unidade
  document.getElementById('unidadeForm').addEventListener('submit', handleUnidadeSubmit);
  
  // Configurar formulário de defensoria
  document.getElementById('orgaoForm').addEventListener('submit', handleOrgaoSubmit);
  
  // Configurar checkboxes para campos condicionais
  setupConditionalFields();
  
  // Fechar modal ao clicar fora dele
  window.onclick = function(event) {
    const loginModal = document.getElementById('loginModal');
    const unidadeModal = document.getElementById('unidadeModal');
    const orgaoModal = document.getElementById('orgaoModal');
    
    if (event.target === loginModal) {
      closeLoginModal();
    } else if (event.target === unidadeModal) {
      closeUnidadeModal();
    } else if (event.target === orgaoModal) {
      closeOrgaoModal();
    }
  };
  
  // Carregar dados da API apenas se não estiver logado como admin
  if (!currentAdmin) {
    await fetchData();
  displayUnits(unidades);
  }
  
  console.log('✅ Aplicação iniciada com sucesso!');
};

/* =========================
   FUNCIONALIDADE DE COLAPSAR/EXPANDIR UNIDADES
========================= */

// Função para alternar o estado de colapso de uma unidade
function toggleUnitCollapse(unidadeId) {
  const unitBody = document.getElementById(`body-${unidadeId}`);
  const unitExtra = document.getElementById(`extra-${unidadeId}`);
  const collapseIcon = document.getElementById(`icon-${unidadeId}`);
  
  if (unitBody && unitExtra && collapseIcon) {
    if (unitBody.style.display === 'none') {
      // Expandir
      unitBody.style.display = 'block';
      unitExtra.style.display = 'block';
      collapseIcon.textContent = '▼';
    } else {
      // Colapsar
      unitBody.style.display = 'none';
      unitExtra.style.display = 'none';
      collapseIcon.textContent = '▶';
    }
  }
}

// Função para colapsar/expandir todas as unidades
function toggleAllUnits() {
  const collapseAllBtn = document.getElementById('collapseAllBtn');
  const collapseAllIcon = document.getElementById('collapseAllIcon');
  const collapseAllText = document.getElementById('collapseAllText');
  
  // Verificar se todas as unidades estão colapsadas
  const allUnits = document.querySelectorAll('.unit');
  let allCollapsed = true;
  
  allUnits.forEach(unit => {
    const unitBody = unit.querySelector('.unit-body');
    const unitExtra = unit.querySelector('.unit-extra');
    
    if (unitBody && unitExtra) {
      if (unitBody.style.display !== 'none' && unitExtra.style.display !== 'none') {
        allCollapsed = false;
      }
    }
  });
  
  // Alternar estado de todas as unidades
  allUnits.forEach(unit => {
    const unitBody = unit.querySelector('.unit-body');
    const unitExtra = unit.querySelector('.unit-extra');
    const collapseIcon = unit.querySelector('.collapse-icon');
    
    if (unitBody && unitExtra && collapseIcon) {
      if (allCollapsed) {
        // Expandir todas
        unitBody.style.display = 'block';
        unitExtra.style.display = 'block';
        collapseIcon.textContent = '▼';
      } else {
        // Colapsar todas
        unitBody.style.display = 'none';
        unitExtra.style.display = 'none';
        collapseIcon.textContent = '▶';
      }
    }
  });
  
  // Atualizar botão
  if (allCollapsed) {
    // Mudar para estado "Colapsar Todas"
    collapseAllBtn.classList.remove('expanded');
    collapseAllIcon.textContent = '📁';
    collapseAllText.textContent = 'Colapsar Todas';
  } else {
    // Mudar para estado "Expandir Todas"
    collapseAllBtn.classList.add('expanded');
    collapseAllIcon.textContent = '📂';
    collapseAllText.textContent = 'Expandir Todas';
  }
}

/* =========================
   GESTÃO DE REGIONAIS
========================= */

// Função para abrir modal de regional
function openRegionalModal(regionalId = null) {
  const modal = document.getElementById('regionalModal');
  const title = document.getElementById('regionalModalTitle');
  const form = document.getElementById('regionalForm');
  
  if (regionalId) {
    title.textContent = 'Editar Regional';
    loadRegionalData(regionalId);
  } else {
    title.textContent = 'Nova Regional';
    form.reset();
  }
  
  modal.style.display = 'block';
}

// Função para fechar modal de regional
function closeRegionalModal() {
  document.getElementById('regionalModal').style.display = 'none';
}

// Função para carregar dados da regional para edição
async function loadRegionalData(regionalId) {
  try {
    const response = await fetch(`${API_BASE_URL}/regionais/${regionalId}`);
    const regional = await response.json();
    
    if (response.ok) {
      document.getElementById('regionalId').value = regional.id;
      document.getElementById('regionalNome').value = regional.nome;
      document.getElementById('regionalNumero').value = regional.numero;
    } else {
      console.error('Erro ao carregar regional:', regional.error);
      alert('Erro ao carregar dados da regional');
    }
  } catch (error) {
    console.error('Erro ao carregar regional:', error);
    alert('Erro ao carregar dados da regional');
  }
}

// Função para salvar regional
async function handleRegionalSubmit(event) {
  event.preventDefault();
  
  const formData = {
    nome: document.getElementById('regionalNome').value,
    numero: parseInt(document.getElementById('regionalNumero').value)
  };
  
  const regionalId = document.getElementById('regionalId').value;
  
  if (!formData.nome || !formData.numero) {
    alert('Nome e número da regional são obrigatórios');
    return;
  }
  
  try {
    const url = regionalId ? `${API_BASE_URL}/regionais/${regionalId}` : `${API_BASE_URL}/regionais`;
    const method = regionalId ? 'PUT' : 'POST';
    
    const response = await fetch(url, {
      method: method,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    });
    
    const result = await response.json();
    
    if (response.ok) {
      alert(result.message);
      closeRegionalModal();
      loadRegionaisList();
    } else {
      alert(result.error || 'Erro ao salvar regional');
    }
  } catch (error) {
    console.error('Erro ao salvar regional:', error);
    alert('Erro ao salvar regional');
  }
}

// Função para carregar lista de regionais
async function loadRegionaisList() {
  try {
    const response = await fetch(`${API_BASE_URL}/regionais`);
    const regionaisData = await response.json();
    
    if (response.ok) {
      regionais = regionaisData;
      originalRegionais = [...regionaisData];
      renderRegionaisList(regionais);
    } else {
      console.error('Erro ao carregar regionais:', regionaisData.error);
    }
  } catch (error) {
    console.error('Erro ao carregar regionais:', error);
  }
}

// Função para renderizar lista de regionais
function renderRegionaisList(regionais) {
  const regionaisList = document.getElementById('regionaisList');
  
  if (!regionaisList) return;
  
  regionaisList.innerHTML = '';
  
  regionais.forEach(regional => {
    const regionalDiv = document.createElement('div');
    regionalDiv.className = 'admin-item';
    regionalDiv.innerHTML = `
      <div class="admin-item-info">
        <h4>${regional.nome}</h4>
        <p><strong>Número:</strong> ${regional.numero}</p>
        <p><strong>Unidades:</strong> ${regional.total_unidades}</p>
        <p><strong>Defensorias:</strong> ${regional.total_defensorias}</p>
        <p><strong>Vagas:</strong> ${regional.defensorias_vagas} | <strong>Afastados:</strong> ${regional.titulares_afastados}</p>
      </div>
      <div class="admin-item-actions">
        <button class="btn-edit" onclick="openRegionalModal(${regional.id})">Editar</button>
        <button class="btn-delete" onclick="deleteRegional(${regional.id})">Excluir</button>
      </div>
    `;
    regionaisList.appendChild(regionalDiv);
  });
}

// Função para excluir regional
async function deleteRegional(regionalId) {
  if (confirm('Tem certeza que deseja excluir esta regional?')) {
    try {
      const response = await fetch(`${API_BASE_URL}/regionais/${regionalId}`, {
        method: 'DELETE'
      });
      
      const result = await response.json();
      
      if (response.ok) {
        alert(result.message);
        loadRegionaisList();
      } else {
        alert(result.error || 'Erro ao excluir regional');
      }
    } catch (error) {
      console.error('Erro ao excluir regional:', error);
      alert('Erro ao excluir regional');
    }
  }
}

// Adicionar event listener para o formulário de regional
document.addEventListener('DOMContentLoaded', function() {
  const regionalForm = document.getElementById('regionalForm');
  if (regionalForm) {
    regionalForm.addEventListener('submit', handleRegionalSubmit);
  }
});

// Função para editar defensoria a partir da tabela de defensorias vagas
function editDefensoriaFromTable(defensoriaId) {
  // Abrir o modal de edição de defensoria
  openOrgaoModal(defensoriaId);
}

// Função para alternar colapso/expansão de tabelas
function toggleTable(tableId) {
  const tableWrapper = document.getElementById(tableId);
  const title = document.querySelector(`[onclick="toggleTable('${tableId}')"]`);
  const icon = title.querySelector('.collapse-icon');

  if (tableWrapper.style.display === 'none' || tableWrapper.style.display === '') {
    // Expandir tabela
    tableWrapper.style.display = 'block';
    icon.classList.add('expanded');
    icon.textContent = '▲';
  } else {
    // Colapsar tabela
    tableWrapper.style.display = 'none';
    icon.classList.remove('expanded');
    icon.textContent = '▼';
  }
}

/* =========================
   FUNÇÕES DE BUSCA
========================= */


// Função de busca para regionais
function searchRegionais(query) {
  if (!query.trim()) {
    regionais = [...originalRegionais];
  } else {
    const normalizedQuery = normalizeText(query);
    regionais = originalRegionais.filter(regional => 
      normalizeText(regional.nome).includes(normalizedQuery) ||
      regional.numero.toString().includes(normalizedQuery) ||
      regional.total_unidades.toString().includes(normalizedQuery) ||
      regional.total_defensorias.toString().includes(normalizedQuery) ||
      regional.defensorias_vagas.toString().includes(normalizedQuery) ||
      regional.titulares_afastados.toString().includes(normalizedQuery)
    );
  }
  renderRegionaisList(regionais);
}

// Função de busca para unidades
function searchUnidades(query) {
  if (!query.trim()) {
    unidades = [...originalUnidades];
  } else {
    const normalizedQuery = normalizeText(query);
    unidades = originalUnidades.filter(unidade => {
      const nomeMatch = normalizeText(unidade.nome).includes(normalizedQuery);
      const regionalMatch = normalizeText(unidade.regional_nome).includes(normalizedQuery);
      const enderecoMatch = normalizeText(unidade.endereco).includes(normalizedQuery);
      const telefoneMatch = normalizeText(unidade.telefone).includes(normalizedQuery);
      const coordenadorMatch = unidade.coordenador && normalizeText(unidade.coordenador).includes(normalizedQuery);
      const supervisorMatch = unidade.supervisor && normalizeText(unidade.supervisor).includes(normalizedQuery);
      
      return nomeMatch || regionalMatch || enderecoMatch || telefoneMatch || coordenadorMatch || supervisorMatch;
    });
  }
  renderUnidadesList(unidades);
}

// Função de busca para defensorias
function searchOrgaos(query) {
  if (!query.trim()) {
    orgaos = [...originalOrgaos];
  } else {
    const normalizedQuery = normalizeText(query);
    orgaos = originalOrgaos.filter(orgao => 
      normalizeText(orgao.nome).includes(normalizedQuery) ||
      normalizeText(orgao.unidade_nome).includes(normalizedQuery) ||
      (orgao.titular_nome && normalizeText(orgao.titular_nome).includes(normalizedQuery)) ||
      (orgao.titular_email && normalizeText(orgao.titular_email).includes(normalizedQuery)) ||
      (orgao.substituto_nome && normalizeText(orgao.substituto_nome).includes(normalizedQuery)) ||
      (orgao.substituto_email && normalizeText(orgao.substituto_email).includes(normalizedQuery))
    );
  }
  renderOrgaosList(orgaos);
}

// Configurar eventos de busca
function setupSearchEvents() {
  // Busca de regionais
  const regionaisSearch = document.getElementById('regionaisSearch');
  if (regionaisSearch && !regionaisSearch.hasAttribute('data-listener-added')) {
    regionaisSearch.addEventListener('input', (e) => {
      searchRegionais(e.target.value);
    });
    regionaisSearch.setAttribute('data-listener-added', 'true');
  }

  // Busca de unidades
  const unidadesSearch = document.getElementById('unidadesSearch');
  if (unidadesSearch && !unidadesSearch.hasAttribute('data-listener-added')) {
    unidadesSearch.addEventListener('input', (e) => {
      searchUnidades(e.target.value);
    });
    unidadesSearch.setAttribute('data-listener-added', 'true');
  }

  // Busca de defensorias
  const orgaosSearch = document.getElementById('orgaosSearch');
  if (orgaosSearch && !orgaosSearch.hasAttribute('data-listener-added')) {
    orgaosSearch.addEventListener('input', (e) => {
      searchOrgaos(e.target.value);
    });
    orgaosSearch.setAttribute('data-listener-added', 'true');
  }
}