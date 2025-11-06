const axios = require('axios');
const config = require('../../config/environment');

class WeatherService {
  constructor() {
    this.cache = new Map();
    this.lastUpdate = null;
  }

  // Obtener datos de ThingSpeak
  async fetchFromThingSpeak(params = {}) {
    try {
      const { results = 10, hours = 24 } = params;
      
      const url = `${config.thingspeak.baseUrl}/channels/${config.thingspeak.channelId}/feeds.json`;
      const response = await axios.get(url, {
        params: {
          results,
          hours,
          api_key: config.thingspeak.apiKey,
        },
        timeout: 10000,
      });

      if (response.status !== 200) {
        throw new Error(`Error en ThingSpeak API: ${response.status}`);
      }

      return response.data;
    } catch (error) {
      console.error('Error fetching from ThingSpeak:', error.message);
      throw new Error(`Error al obtener datos de ThingSpeak: ${error.message}`);
    }
  }

  // Procesar datos de ThingSpeak
  processThingSpeakData(rawData) {
    if (!rawData.feeds || !Array.isArray(rawData.feeds)) {
      return [];
    }

    return rawData.feeds.map(feed => ({
      id: feed.entry_id,
      createdAt: new Date(feed.created_at),
      temperature: parseFloat(feed.field1) || 0,
      humidity: parseFloat(feed.field2) || 0,
      pressure: parseFloat(feed.field3) || 0,
      windSpeed: feed.field4 ? parseFloat(feed.field4) : null,
      windDirection: feed.field5 ? parseFloat(feed.field5) : null,
      rainfall: feed.field6 ? parseFloat(feed.field6) : null,
    }));
  }

  // Obtener datos meteorológicos
  async getWeatherData(params = {}) {
    const cacheKey = `weather_${JSON.stringify(params)}`;
    const now = new Date();
    
    // Verificar caché
    if (this.cache.has(cacheKey)) {
      const cached = this.cache.get(cacheKey);
      const cacheAge = now - cached.timestamp;
      const cacheExpiration = config.cache.durationMinutes * 60 * 1000;
      
      if (cacheAge < cacheExpiration) {
        console.log('📦 Sirviendo datos desde caché');
        return cached.data;
      }
    }

    try {
      console.log('🌐 Obteniendo datos de ThingSpeak...');
      const rawData = await this.fetchFromThingSpeak(params);
      const processedData = this.processThingSpeakData(rawData);
      
      // Actualizar caché
      this.cache.set(cacheKey, {
        data: processedData,
        timestamp: now,
      });
      
      this.lastUpdate = now;
      console.log(`✅ Obtenidos ${processedData.length} registros meteorológicos`);
      
      return processedData;
    } catch (error) {
      console.error('Error en getWeatherData:', error);
      
      // Intentar servir datos del caché si están disponibles
      if (this.cache.has(cacheKey)) {
        console.log('⚠️ Sirviendo datos obsoletos desde caché');
        return this.cache.get(cacheKey).data;
      }
      
      throw error;
    }
  }

  // Obtener datos más recientes
  async getLatestWeatherData() {
    const data = await this.getWeatherData({ results: 1 });
    return data.length > 0 ? data[0] : null;
  }

  // Obtener estadísticas
  async getWeatherStats(hours = 24) {
    const data = await this.getWeatherData({ results: 100, hours });
    
    if (data.length === 0) {
      return {
        temperature: { min: 0, max: 0, avg: 0 },
        humidity: { min: 0, max: 0, avg: 0 },
        pressure: { min: 0, max: 0, avg: 0 },
        windSpeed: { min: 0, max: 0, avg: 0 },
        recordCount: 0,
      };
    }

    const temperatures = data.map(d => d.temperature).filter(t => !isNaN(t));
    const humidities = data.map(d => d.humidity).filter(h => !isNaN(h));
    const pressures = data.map(d => d.pressure).filter(p => !isNaN(p));
    const windSpeeds = data.map(d => d.windSpeed).filter(w => w !== null && !isNaN(w));

    return {
      temperature: {
        min: Math.min(...temperatures),
        max: Math.max(...temperatures),
        avg: temperatures.reduce((a, b) => a + b, 0) / temperatures.length,
      },
      humidity: {
        min: Math.min(...humidities),
        max: Math.max(...humidities),
        avg: humidities.reduce((a, b) => a + b, 0) / humidities.length,
      },
      pressure: {
        min: Math.min(...pressures),
        max: Math.max(...pressures),
        avg: pressures.reduce((a, b) => a + b, 0) / pressures.length,
      },
      windSpeed: windSpeeds.length > 0 ? {
        min: Math.min(...windSpeeds),
        max: Math.max(...windSpeeds),
        avg: windSpeeds.reduce((a, b) => a + b, 0) / windSpeeds.length,
      } : { min: 0, max: 0, avg: 0 },
      recordCount: data.length,
    };
  }

  // Obtener datos históricos
  async getWeatherHistory(params) {
    const { startDate, endDate, results = 100 } = params;
    
    // ThingSpeak no soporta filtros de fecha directamente,
    // así que obtenemos más datos y los filtramos
    const data = await this.getWeatherData({ results: Math.min(results * 2, 8000) });
    
    return data.filter(item => {
      const itemDate = new Date(item.createdAt);
      return itemDate >= startDate && itemDate <= endDate;
    }).slice(0, results);
  }

  // Limpiar caché
  clearCache() {
    this.cache.clear();
    this.lastUpdate = null;
    console.log('🗑️ Caché limpiado');
  }

  // Obtener estado del caché
  getCacheStatus() {
    return {
      cacheSize: this.cache.size,
      lastUpdate: this.lastUpdate,
      cacheKeys: Array.from(this.cache.keys()),
    };
  }
}

module.exports = new WeatherService();
