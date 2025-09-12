/**
 * Feature Flags Configuration
 * Controla a ativação/desativação de funcionalidades durante a refatoração
 */

const FEATURES = {
  // Arquitetura Nova
  NEW_ARCHITECTURE: process.env.FEATURE_NEW_ARCH === 'true',
  
  // Módulos específicos
  NEW_UNIT_CRUD: process.env.FEATURE_NEW_UNIT_CRUD === 'true',
  NEW_DEFENSORIA_CRUD: process.env.FEATURE_NEW_DEFENSORIA_CRUD === 'true',
  NEW_REGIONAL_CRUD: process.env.FEATURE_NEW_REGIONAL_CRUD === 'true',
  NEW_AUTH_FLOW: process.env.FEATURE_NEW_AUTH_FLOW === 'true',
  
  // UI Nova
  NEW_UI_COMPONENTS: process.env.FEATURE_NEW_UI === 'true',
  
  // Observabilidade
  NEW_LOGGING: process.env.FEATURE_NEW_LOGGING === 'true',
  NEW_METRICS: process.env.FEATURE_NEW_METRICS === 'true'
};

/**
 * Verifica se uma feature está ativa
 * @param {string} featureName - Nome da feature
 * @returns {boolean}
 */
function isFeatureEnabled(featureName) {
  return FEATURES[featureName] === true;
}

/**
 * Retorna todas as features ativas
 * @returns {Object}
 */
function getActiveFeatures() {
  return Object.keys(FEATURES).filter(key => FEATURES[key] === true);
}

module.exports = {
  FEATURES,
  isFeatureEnabled,
  getActiveFeatures
};
