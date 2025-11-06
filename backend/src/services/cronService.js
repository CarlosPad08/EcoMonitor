const cron = require('node-cron');
const weatherService = require('./weatherService');
const config = require('../../config/environment');

const setupCronJobs = () => {
  console.log('⏰ Configurando trabajos cron...');
  
  // Limpiar caché cada hora
  cron.schedule('0 * * * *', () => {
    console.log('🧹 Limpiando caché programado...');
    weatherService.clearCache();
  });
  
  // Pre-cargar datos cada 5 minutos
  cron.schedule(`*/${config.cache.refreshIntervalMinutes} * * * *`, async () => {
    try {
      console.log('🔄 Pre-cargando datos meteorológicos...');
      await weatherService.getWeatherData({ results: 10 });
      console.log('✅ Pre-carga completada');
    } catch (error) {
      console.error('❌ Error en pre-carga:', error.message);
    }
  });
  
  console.log(`✅ Trabajos cron configurados:
    - Limpieza de caché: cada hora
    - Pre-carga de datos: cada ${config.cache.refreshIntervalMinutes} minutos`);
};

module.exports = { setupCronJobs };
