# 🌤️ EcoMonitor Backend

Backend API para la aplicación EcoMonitor - Estación Meteorológica de Tulúa.

## 🚀 Características

- ✅ API REST para datos meteorológicos
- ✅ Integración con ThingSpeak
- ✅ Sistema de caché inteligente
- ✅ Tareas programadas (Cron)
- ✅ Validación de parámetros
- ✅ Manejo de errores robusto
- ✅ Logging detallado
- ✅ Seguridad con Helmet

## 📊 Endpoints Disponibles

### Salud del Servidor
```
GET /health
```
Respuesta:
```json
{
  "status": "OK",
  "timestamp": "2024-01-01T12:00:00.000Z",
  "app": "EcoMonitor Backend",
  "version": "1.0.0",
  "environment": "development"
}
```

### Datos Meteorológicos
```
GET /api/weather?results=10&hours=24
```

**Parámetros:**
- `results` (opcional): Número de registros (1-8000, default: 10)
- `hours` (opcional): Horas hacia atrás (1-168, default: 24)

**Respuesta:**
```json
{
  "success": true,
  "data": [
    {
      "id": "12345",
      "createdAt": "2024-01-01T12:00:00.000Z",
      "temperature": 25.5,
      "humidity": 60.0,
      "pressure": 1013.25,
      "windSpeed": 5.2,
      "windDirection": 180.0,
      "rainfall": 0.0
    }
  ],
  "meta": {
    "count": 1,
    "requested": 10,
    "timestamp": "2024-01-01T12:00:00.000Z"
  }
}
```

### Último Dato
```
GET /api/weather/latest
```

### Estadísticas
```
GET /api/weather/stats?hours=24
```

**Respuesta:**
```json
{
  "success": true,
  "data": {
    "temperature": {
      "min": 20.0,
      "max": 30.0,
      "avg": 25.0
    },
    "humidity": {
      "min": 40.0,
      "max": 80.0,
      "avg": 60.0
    },
    "pressure": {
      "min": 1010.0,
      "max": 1020.0,
      "avg": 1015.0
    },
    "windSpeed": {
      "min": 0.0,
      "max": 15.0,
      "avg": 5.0
    },
    "recordCount": 24
  }
}
```

### Datos Históricos
```
GET /api/weather/history?start=2024-01-01&end=2024-01-02&results=100
```

## 🛠️ Instalación

1. **Instalar dependencias:**
```bash
npm install
```

2. **Configurar variables de entorno:**
```bash
cp .env.example .env
```

3. **Editar `.env`:**
```env
PORT=3000
THINGSPEAK_CHANNEL_ID=2214906
THINGSPEAK_API_KEY=TU_API_KEY_AQUI
THINGSPEAK_BASE_URL=https://api.thingspeak.com
NODE_ENV=development
CACHE_DURATION_MINUTES=5
REFRESH_INTERVAL_MINUTES=5
```

4. **Ejecutar:**
```bash
# Desarrollo
npm run dev

# Producción
npm start
```

## 🔧 Configuración

### Variables de Entorno

| Variable | Descripción | Default |
|----------|-------------|---------|
| `PORT` | Puerto del servidor | 3000 |
| `THINGSPEAK_CHANNEL_ID` | ID del canal ThingSpeak | 2214906 |
| `THINGSPEAK_API_KEY` | API Key de ThingSpeak | - |
| `THINGSPEAK_BASE_URL` | URL base de ThingSpeak | https://api.thingspeak.com |
| `NODE_ENV` | Entorno de ejecución | development |
| `CACHE_DURATION_MINUTES` | Duración del caché | 5 |
| `REFRESH_INTERVAL_MINUTES` | Intervalo de actualización | 5 |

### Caché

El sistema implementa un caché inteligente que:
- Almacena datos por 5 minutos por defecto
- Se actualiza automáticamente cada 5 minutos
- Se limpia cada hora
- Sirve datos obsoletos si la API falla

### Tareas Programadas

- **Pre-carga**: Cada 5 minutos obtiene datos frescos
- **Limpieza**: Cada hora limpia el caché

## 📝 Logs

El servidor registra:
- ✅ Peticiones HTTP
- 🌐 Llamadas a ThingSpeak
- 📦 Uso del caché
- ❌ Errores y excepciones
- ⏰ Tareas programadas

## 🔒 Seguridad

- **Helmet**: Headers de seguridad
- **CORS**: Configuración de origen
- **Validación**: Parámetros de entrada
- **Rate Limiting**: (Próximamente)

## 🧪 Testing

```bash
# Ejecutar tests
npm test

# Tests con coverage
npm run test:coverage
```

## 📈 Monitoreo

### Health Check
```bash
curl http://localhost:3000/health
```

### Estado del Caché
```bash
curl http://localhost:3000/api/weather/stats
```

## 🚀 Despliegue

### Docker
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### PM2
```bash
npm install -g pm2
pm2 start src/app.js --name eco-monitor
pm2 save
pm2 startup
```

## 📊 Métricas

- **Uptime**: Tiempo de funcionamiento
- **Cache Hit Rate**: Eficiencia del caché
- **API Response Time**: Tiempo de respuesta
- **Error Rate**: Tasa de errores

## 🔧 Desarrollo

### Estructura del Código
```
src/
├── app.js                 # Aplicación principal
├── controllers/          # Controladores de rutas
│   └── weatherController.js
├── services/             # Lógica de negocio
│   ├── weatherService.js
│   └── cronService.js
└── middleware/           # Middleware personalizado
    ├── errorHandler.js
    └── validation.js
```

### Agregar Nuevos Endpoints

1. Crear controlador en `controllers/`
2. Agregar servicio en `services/`
3. Registrar ruta en `app.js`
4. Agregar validaciones en `middleware/`

## 🐛 Troubleshooting

### Error: "ThingSpeak API no disponible"
- Verificar API key
- Comprobar conectividad
- Revisar logs del servidor

### Error: "Caché no funciona"
- Verificar configuración de caché
- Comprobar memoria disponible
- Revisar logs de caché

### Error: "Puerto en uso"
```bash
# Encontrar proceso
lsof -i :3000

# Matar proceso
kill -9 PID
```

## 📞 Soporte

- **Issues**: GitHub Issues
- **Documentación**: README.md
- **Logs**: Console output

---

**EcoMonitor Backend** - API para monitoreo meteorológico 🌤️
