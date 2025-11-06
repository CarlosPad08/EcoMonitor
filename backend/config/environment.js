require('dotenv').config();

const config = {
  port: process.env.PORT || 3000,
  nodeEnv: process.env.NODE_ENV || 'development',
  appName: process.env.APP_NAME || 'EcoMonitor Backend',
  appVersion: process.env.APP_VERSION || '1.0.0',
  
  // ThingSpeak Configuration
  thingspeak: {
    channelId: process.env.THINGSPEAK_CHANNEL_ID || '2214906',
    apiKey: process.env.THINGSPEAK_API_KEY || '',
    baseUrl: process.env.THINGSPEAK_BASE_URL || 'https://api.thingspeak.com',
  },
  
  // Cache Configuration
  cache: {
    durationMinutes: parseInt(process.env.CACHE_DURATION_MINUTES) || 5,
    refreshIntervalMinutes: parseInt(process.env.REFRESH_INTERVAL_MINUTES) || 5,
  },
  
  // CORS Configuration
  cors: {
    origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  },
};

module.exports = config;
