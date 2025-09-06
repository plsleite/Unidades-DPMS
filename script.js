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
   DADOS
========================= */
const unidades = [
  {
    nome: "RIO VERDE DE MATO GROSSO | FÓRUM",
    endereco: "Rua Eurico S. Ferreira, 640 - CEP: 79480-000",
    telefone: "(67) 2025-0136",
    campoGrande: false,
    orgaos: [
      {
        nome: "Defensoria Pública de Rio Verde de Mato Grosso",
        titular: {
          nome: "Pedro de Luna Souza Leite",
          email: "pedrol@defensoria.ms.def.br",
          afastado: true
        },
        substituto: {
          nome: "Rodrigo Duarte Quaresma",
          email: "rodrigod@defensoria.ms.def.br"
        }
      }
    ]
  },
  {
    nome: "SIDROLÂNDIA | CENTRO",
    endereco: "Rua Distrito Federal, 986 - Centro - CEP: 79170-000",
    telefone: "(67) 2025-0143",
    campoGrande: false,
    orgaos: [
      {
        nome: "1ª Defensoria Pública Cível de Sidrolândia",
        titular: {
          nome: "Vaga",
          email: null,
          vaga: true
        },
        substituto: {
          nome: "Marcos Braga da Fonseca",
          email: "marcosb@defensoria.ms.def.br"
        }
      },
      {
        nome: "2ª Defensoria Pública Cível de Sidrolândia",
        titular: {
          nome: "Marcos Braga da Fonseca",
          email: "marcosb@defensoria.ms.def.br"
        },
        substituto: null
      },
      {
        nome: "1ª Defensoria Pública Criminal de Sidrolândia",
        titular: {
          nome: "Vaga",
          email: null,
          vaga: true
        },
        substituto: {
          nome: "Leonardo Gelatti Backes",
          email: "lbackes@defensoria.ms.def.br"
        }
      }
    ]
  }
];

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
window.onload = () => {
  displayUnits(unidades);
};
