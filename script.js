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
const API_BASE_URL = 'http://localhost:3000/api';
let unidades = []; // Array vazio - será preenchido pela API
let regionais = []; // Array vazio - será preenchido pela API
let isLoading = false;
let currentAdmin = null; // Dados do administrador logado
let selectedRegionais = []; // Array para armazenar regionais selecionadas

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
  
  const rawInput = document.getElementById("searchInput").value.trim();
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
    
    let message = "🔎 Exibindo apenas Defensorias vagas.";
    if (selectedRegionais.length > 0) {
      const regionaisNomes = selectedRegionais.map(id => 
        regionais.find(r => r.id === id)?.nome
      ).filter(Boolean).join(', ');
      message += ` (Regionais: ${regionaisNomes})`;
    }
    displayUnits(filtered, message);

  } else if (selectedFilter === "afastados") {
    filtered = filtered
      .map(u => ({ ...u, orgaos: u.orgaos.filter(o => o.titular.afastado === true) }))
      .filter(u => u.orgaos.length > 0);
    
    let message = "🔎 Exibindo apenas Defensorias com titulares afastados.";
    if (selectedRegionais.length > 0) {
      const regionaisNomes = selectedRegionais.map(id => 
        regionais.find(r => r.id === id)?.nome
      ).filter(Boolean).join(', ');
      message += ` (Regionais: ${regionaisNomes})`;
    }
    displayUnits(filtered, message);

  } else {
    let message = "";
    if (selectedRegionais.length > 0) {
      const regionaisNomes = selectedRegionais.map(id => 
        regionais.find(r => r.id === id)?.nome
      ).filter(Boolean).join(', ');
      message = `🔎 Exibindo unidades das regionais: ${regionaisNomes}`;
    }
    displayUnits(filtered, message);
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
    
    const unidadesList = document.getElementById('unidadesList');
    unidadesList.innerHTML = '';
    
    unidadesData.forEach(unidade => {
      const unidadeDiv = document.createElement('div');
      unidadeDiv.className = 'admin-item';
      unidadeDiv.innerHTML = `
        <div class="admin-item-info">
          <h4>${unidade.nome}</h4>
          <p>${unidade.endereco} • ${unidade.regional_nome || 'Sem regional'}</p>
          <p>Coordenador: ${unidade.coordenador || 'Não informado'}</p>
        </div>
        <div class="admin-item-actions">
          <button class="btn-edit" onclick="editUnidade(${unidade.id})">Editar</button>
          <button class="btn-delete" onclick="deleteUnidade(${unidade.id})">Excluir</button>
        </div>
      `;
      unidadesList.appendChild(unidadeDiv);
    });
  } catch (error) {
    console.error('Erro ao carregar unidades:', error);
  }
}

// Carregar lista de defensorias para administração
async function loadOrgaosList() {
  try {
    const response = await fetch(`${API_BASE_URL}/orgaos`);
    const orgaosData = await response.json();
    
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
  } catch (error) {
    console.error('Erro ao carregar defensorias:', error);
  }
}

// Funções de navegação entre abas
function showAdminTab(tabName) {
  // Remover classe active de todas as abas e conteúdos
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
  document.querySelectorAll('.admin-tab-content').forEach(content => content.classList.remove('active'));
  
  // Ativar aba e conteúdo selecionados
  event.target.classList.add('active');
  document.getElementById(`admin${tabName.charAt(0).toUpperCase() + tabName.slice(1)}`).classList.add('active');
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
      document.getElementById('unidadeRegional').value = unidade.regional_id || '';
      
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
  const temCoordenador = document.getElementById('unidadeTemCoordenador').checked;
  const temSupervisor = document.getElementById('unidadeTemSupervisor').checked;
  
  const formData = {
    nome: document.getElementById('unidadeNome').value,
    endereco: document.getElementById('unidadeEndereco').value,
    telefone: document.getElementById('unidadeTelefone').value,
    regional_id: document.getElementById('unidadeRegional').value || null,
    coordenador: temCoordenador ? document.getElementById('unidadeCoordenador').value : null,
    email_coordenador: temCoordenador ? document.getElementById('unidadeEmailCoordenador').value : null,
    supervisor: temSupervisor ? document.getElementById('unidadeSupervisor').value : null,
    email_supervisor: temSupervisor ? document.getElementById('unidadeEmailSupervisor').value : null
  };
  
  // Validações
  if (!formData.nome || !formData.endereco || !formData.telefone || !formData.regional_id) {
    alert('Nome, endereço, telefone e regional são obrigatórios');
    return;
  }
  
  if (temCoordenador && (!formData.coordenador || !formData.email_coordenador)) {
    alert('Nome e email do coordenador são obrigatórios quando marcado');
    return;
  }
  
  if (temSupervisor && (!formData.supervisor || !formData.email_supervisor)) {
    alert('Nome e email do supervisor são obrigatórios quando marcado');
    return;
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
  fetch(`${API_BASE_URL}/unidades`)
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