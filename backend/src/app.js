const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const morgan = require('morgan');
const config = require('../config/environment');
const weatherRoutes = require('./controllers/weatherController');
const { errorHandler } = require('./middleware/errorHandler');
const { setupCronJobs } = require('./services/cronService');

const app = express();

// Middleware de seguridad
app.use(helmet());
app.use(compression());
app.use(morgan('combined'));

// CORS
app.use(cors({
  origin: config.cors.origin,
  credentials: true,
}));

// Body parsing
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Rutas
app.use('/api/weather', weatherRoutes);

// Ruta de salud
app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    app: config.appName,
    version: config.appVersion,
    environment: config.nodeEnv,
  });
});

// Ruta raíz
app.get('/', (req, res) => {
  res.json({
    message: 'EcoMonitor API - Estación Meteorológica de Tulúa',
    version: config.appVersion,
    endpoints: {
      health: '/health',
      weather: '/api/weather',
    },
  });
});

// Manejo de errores
app.use(errorHandler);

// Iniciar servidor
const server = app.listen(config.port, () => {
  console.log(`🚀 ${config.appName} v${config.appVersion} corriendo en puerto ${config.port}`);
  console.log(`🌍 Entorno: ${config.nodeEnv}`);
  console.log(`📊 Health check: http://localhost:${config.port}/health`);
  console.log(`🌤️  Weather API: http://localhost:${config.port}/api/weather`);
});

// Configurar trabajos cron
setupCronJobs();

// Manejo graceful de shutdown
process.on('SIGTERM', () => {
  console.log('🛑 Recibida señal SIGTERM, cerrando servidor...');
  server.close(() => {
    console.log('✅ Servidor cerrado correctamente');
    process.exit(0);
  });
});

process.on('SIGINT', () => {
  console.log('🛑 Recibida señal SIGINT, cerrando servidor...');
  server.close(() => {
    console.log('✅ Servidor cerrado correctamente');
    process.exit(0);
  });
});

module.exports = app;
