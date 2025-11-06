# 🌤️ EcoMonitor - Estación Meteorológica de Tulúa

Aplicación Flutter para monitorear el clima de Tulúa a través de una estación meteorológica conectada a ThingSpeak.

## 🏗️ Arquitectura del Proyecto

```
EcoMonitor/
├── lib/                          # Código Flutter
│   ├── core/                     # Configuraciones centrales
│   │   ├── constants/           # Constantes de la app
│   │   ├── errors/              # Manejo de errores
│   │   ├── network/             # Configuración de red
│   │   └── utils/               # Utilidades generales
│   ├── features/                # Características de la app
│   │   └── weather/             # Módulo del clima
│   │       ├── data/            # Capa de datos
│   │       ├── domain/          # Lógica de negocio
│   │       └── presentation/    # UI
│   ├── shared/                  # Componentes compartidos
│   │   ├── widgets/             # Widgets reutilizables
│   │   └── themes/              # Temas y estilos
│   └── main.dart                 # Punto de entrada
├── backend/                     # Backend Node.js
│   ├── src/                     # Código del servidor
│   │   ├── controllers/         # Controladores de rutas
│   │   ├── services/            # Lógica de negocio
│   │   └── middleware/          # Middleware personalizado
│   ├── config/                  # Configuraciones
│   └── package.json             # Dependencias Node.js
└── assets/                      # Recursos estáticos
    └── images/                  # Imágenes e iconos
```

## 🚀 Tecnologías Utilizadas

### Frontend (Flutter)
- **Flutter**: Framework de UI
- **Riverpod**: Gestión de estado
- **Dio**: Cliente HTTP
- **FL Chart**: Gráficos
- **Shimmer**: Efectos de carga

### Backend (Node.js)
- **Express**: Framework web
- **Axios**: Cliente HTTP
- **Node-cron**: Tareas programadas
- **Helmet**: Seguridad
- **CORS**: Configuración CORS

## 📱 Características

- ✅ Dashboard en tiempo real
- ✅ Histórico de datos meteorológicos
- ✅ Gráficos de tendencias
- ✅ Modo offline
- ✅ Actualización automática
- ✅ Diseño responsive
- ✅ Tema claro/oscuro

## 🛠️ Instalación y Configuración

### Prerrequisitos
- Flutter SDK (>=3.0.0)
- Node.js (>=18.0.0)
- npm o yarn

### Frontend (Flutter)

1. **Instalar dependencias:**
```bash
flutter pub get
```

2. **Configurar API:**
Editar `lib/core/constants/app_constants.dart`:
```dart
static const String apiKey = 'TU_API_KEY_DE_THINGSPEAK';
```

3. **Ejecutar la aplicación:**
```bash
flutter run
```

### Backend (Node.js)

1. **Instalar dependencias:**
```bash
cd backend
npm install
```

2. **Configurar variables de entorno:**
Crear archivo `.env` basado en `.env.example`:
```bash
cp .env.example .env
```

3. **Configurar ThingSpeak:**
Editar `.env`:
```env
THINGSPEAK_CHANNEL_ID=2214906
THINGSPEAK_API_KEY=TU_API_KEY
```

4. **Ejecutar el servidor:**
```bash
# Desarrollo
npm run dev

# Producción
npm start
```

## 📊 API Endpoints

### Backend
- `GET /health` - Estado del servidor
- `GET /api/weather` - Datos meteorológicos
- `GET /api/weather/latest` - Último dato
- `GET /api/weather/stats` - Estadísticas
- `GET /api/weather/history` - Datos históricos

### Parámetros
- `results`: Número de registros (1-8000)
- `hours`: Horas hacia atrás (1-168)
- `start/end`: Fechas para histórico

## 🎨 Diseño

La aplicación utiliza Material Design 3 con un tema personalizado inspirado en el clima:

- **Colores principales**: Verde (naturaleza/clima)
- **Temperatura**: Naranja/Rojo
- **Humedad**: Azul
- **Presión**: Púrpura
- **Viento**: Cian

## 📱 Pantallas

1. **Dashboard Principal**: Datos actuales del clima
2. **Histórico**: Gráficos de tendencias
3. **Configuración**: Ajustes de la aplicación

## 🔧 Desarrollo

### Estructura de Datos
```json
{
  "id": "12345",
  "createdAt": "2024-01-01T12:00:00Z",
  "temperature": 25.5,
  "humidity": 60.0,
  "pressure": 1013.25,
  "windSpeed": 5.2,
  "windDirection": 180.0,
  "rainfall": 0.0
}
```

### Flujo de Datos
1. **Estación Meteorológica** → **ThingSpeak**
2. **Backend** → **ThingSpeak API**
3. **Flutter App** → **Backend API**
4. **Cache Local** → **Datos Offline**

## 📈 Próximas Características

- [ ] Notificaciones push
- [ ] Exportar datos
- [ ] Múltiples estaciones
- [ ] Predicciones meteorológicas
- [ ] Alertas personalizadas

## 🤝 Contribución

1. Fork el proyecto
2. Crear una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abrir un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver `LICENSE` para más detalles.

## 👥 Equipo

- **Desarrollo**: EcoMonitor Team
- **Estación**: Universidad del Valle - Sede Tulúa
- **API**: ThingSpeak

---

**EcoMonitor** - Monitoreando el clima de Tulúa 🌤️