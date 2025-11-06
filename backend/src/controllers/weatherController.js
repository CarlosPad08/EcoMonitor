const express = require('express');
const weatherService = require('../services/weatherService');
const { validateQueryParams } = require('../middleware/validation');

const router = express.Router();

// Obtener datos meteorológicos
router.get('/', validateQueryParams, async (req, res, next) => {
  try {
    const { results = 10, hours = 24 } = req.query;
    
    const weatherData = await weatherService.getWeatherData({
      results: parseInt(results),
      hours: parseInt(hours),
    });
    
    res.json({
      success: true,
      data: weatherData,
      meta: {
        count: weatherData.length,
        requested: parseInt(results),
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    next(error);
  }
});

// Obtener datos más recientes
router.get('/latest', async (req, res, next) => {
  try {
    const latestData = await weatherService.getLatestWeatherData();
    
    if (!latestData) {
      return res.status(404).json({
        success: false,
        message: 'No hay datos disponibles',
      });
    }
    
    res.json({
      success: true,
      data: latestData,
      meta: {
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    next(error);
  }
});

// Obtener estadísticas
router.get('/stats', async (req, res, next) => {
  try {
    const { hours = 24 } = req.query;
    const stats = await weatherService.getWeatherStats(parseInt(hours));
    
    res.json({
      success: true,
      data: stats,
      meta: {
        period: `${hours} horas`,
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    next(error);
  }
});

// Obtener datos históricos por rango de fechas
router.get('/history', async (req, res, next) => {
  try {
    const { start, end, results = 100 } = req.query;
    
    if (!start || !end) {
      return res.status(400).json({
        success: false,
        message: 'Se requieren los parámetros start y end',
      });
    }
    
    const historyData = await weatherService.getWeatherHistory({
      startDate: new Date(start),
      endDate: new Date(end),
      results: parseInt(results),
    });
    
    res.json({
      success: true,
      data: historyData,
      meta: {
        count: historyData.length,
        startDate: start,
        endDate: end,
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    next(error);
  }
});

module.exports = router;
