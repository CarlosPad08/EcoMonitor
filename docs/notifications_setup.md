# Notificaciones (FCM + Local) — EcoMonitor

Este documento recoge la guía completa desde "Pasos completos de configuración (Flutter Android + backend FCM)" en adelante, con ejemplos y buenas prácticas.

---

## Pasos completos de configuración (Flutter Android + backend FCM)

**Requisitos**
- Flutter SDK instalado y en `PATH`.
- Android Studio con Android SDK y AVD Manager.
- Node.js >= 18 para el backend.
- Proyecto Firebase creado (https://console.firebase.google.com/) y app Android registrada.

### A) Flutter (cliente)

1. En `pubspec.yaml` añade las dependencias necesarias (ya añadidas en este repo):
   - `firebase_core`
   - `firebase_messaging`
   - `flutter_local_notifications`

   Ejecuta:
```powershell
cd C:\Users\HARRISON\Documents\EcoMonitor
flutter pub get
```

2. Configurar Firebase Android:
- En Firebase Console añade una app Android y descarga `google-services.json`.
- Copia `google-services.json` en `android/app/`.
- Edita los `build.gradle` según la guía oficial de Firebase Flutter (https://firebase.flutter.dev/docs/installation/android).

3. Permisos Android (Android 13+):
- Añade en `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```
- Pide el permiso en tiempo de ejecución desde Flutter (se muestra más abajo).

4. Inicializar en `main.dart` (antes de `runApp`):
```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(const MyApp());
}
```


### B) Backend (envío via FCM)
1. En la carpeta `backend/` instala `firebase-admin`:
```powershell
cd C:\Users\HARRISON\Documents\EcoMonitor\backend
npm install firebase-admin
```
2. Crea un service account (Firebase Console → Project settings → Service accounts → Generar clave privada) y descarga el JSON.
3. Exporta la variable de entorno (PowerShell):
```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS='C:\path\to\serviceAccountKey.json'
```
4. Ejemplo: `backend/src/fcm_sender.js` (ya incluido en el repo). Para ejecutar el demo:
```powershell
node backend/src/fcm_sender.js
```

---

## JSON simulado (assets)

Archivo: `assets/data/alerts.json`

Ejemplo:
```json
[
  {
    "id":"1",
    "type":"rain",
    "title":"🌧️ Lluvia fuerte detectada en Tulúa",
    "message":"Se ha detectado lluvia intensa en la zona centro de Tulúa. Evita desplazamientos innecesarios.",
    "severity":"high",
    "timestamp":"2025-11-26T09:00:00Z"
  },
  {
    "id":"2",
    "type":"uv",
    "title":"☀️ Alta radiación solar – Evita exponerte al sol",
    "message":"Índice UV muy alto. Usa protector solar y evita la exposición prolongada entre 10:00 y 16:00.",
    "severity":"medium",
    "timestamp":"2025-11-26T10:00:00Z"
  },
  {
    "id":"3",
    "type":"pressure",
    "title":"🌬️ Cambio brusco de presión – posible tormenta",
    "message":"La presión atmosférica ha caído bruscamente. Hay probabilidad de tormentas en las próximas horas.",
    "severity":"high",
    "timestamp":"2025-11-26T11:00:00Z"
  }
]
```

Uso en cliente: `rootBundle.loadString('assets/data/alerts.json')` y luego mostrar notificaciones locales.

---

## Configurar notificaciones en segundo plano (resumen)

- Declara un handler de background en Dart (top-level): `firebaseMessagingBackgroundHandler(RemoteMessage message)`.
- Llama `FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);` en la inicialización.
- Usa `FirebaseMessaging.onMessage.listen(...)` para mensajes en primer plano.
- Usa `FirebaseMessaging.onMessageOpenedApp.listen(...)` para manejar taps cuando había estado en background.
- Inicializa `flutter_local_notifications` para mostrar notificaciones locales tanto en foreground como en background.

Notas: el background handler debe inicializar Firebase y `flutter_local_notifications` si necesita mostrar UI.

---

## Ejemplos de uso

### A) Enviar notificación desde backend (Node.js / firebase-admin)
- `backend/src/fcm_sender.js` (ya incluido): ejemplos de `sendToTopic(topic, title, body, data)` y `sendToToken(token, title, body, data)`.

### B) Mostrar notificación local cuando llega mensaje (cliente)
- `NotificationService` (archivo añadido `lib/core/notifications/notification_service.dart`) escucha `FirebaseMessaging.onMessage` y usa `flutter_local_notifications` para mostrar la notificación.

### C) Manejar taps en notificaciones
- Cold start: `final initialMessage = await FirebaseMessaging.instance.getInitialMessage();`
- Background -> opened: `FirebaseMessaging.onMessageOpenedApp.listen((message) { ... });`
- Notificaciones locales: manejar `onDidReceiveNotificationResponse` de `flutter_local_notifications` para leer `payload`.

---

## Notificaciones personalizadas según el clima

Mapear `type` del evento al contenido de la notificación:
- `rain` → Título: `🌧️ Lluvia fuerte detectada en Tulúa`.
- `uv` → Título: `☀️ Alta radiación solar – Evita exponerte al sol`.
- `pressure` → Título: `🌬️ Cambio brusco de presión – posible tormenta`.

Enviar `data` adicional en el mensaje FCM para que la app actúe (ej. `type`, `severity`, `timestamp`, `location`).

---

## Ejemplos de notificaciones automáticas

- “🌧️ Lluvia fuerte detectada en Tulúa”
- “☀️ Alta radiación solar – Evita exponerte al sol”
- “🌬️ Cambio brusco de presión – posible tormenta”

Puedes enviarlas desde backend a un `topic` (ej. `alerts_tulua`) o programarlas localmente en el cliente.

---

## Pedir permiso al usuario (Android 13+)

En Android 13+ se solicita `POST_NOTIFICATIONS`. En Dart:
```dart
NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
  alert: true,
  badge: true,
  sound: true,
);
```
Alternativa: usar `permission_handler` si quieres control avanzado.

---

## Programar alertas locales (ej.: cada hora)

Usa `flutter_local_notifications.periodicallyShow` o `zonedSchedule` para programación con zonas horarias.

Ejemplo ya incluido en `NotificationService.scheduleHourlyAlert`:
```dart
await NotificationService().scheduleHourlyAlert(
  id: 'hourly_alert',
  title: 'Recordatorio EcoMonitor',
  body: 'Revisa las condiciones meteorológicas actuales.',
);
```

---

## Buenas prácticas y errores comunes

**Buenas prácticas**
- Registrar tokens en backend para envíos dirigidos.
- Usar topics para alertas geográficas.
- Enviar `data` junto con `notification` para que el cliente procese la lógica.
- Crear canales Android por tipo/severidad.
- Probar en foreground, background y cold start.

**Errores comunes**
- No poner `google-services.json` → FCM no funciona.
- No inicializar Firebase antes de `FirebaseMessaging`.
- No inicializar `flutter_local_notifications` en el background handler.
- Olvidar `POST_NOTIFICATIONS` en AndroidManifest (Android 13+).
- Emulador sin Google Play services → los push no llegan.
- Tokens expirados: pedir `getToken()` regularmente.

---

## Probar rápido (pasos)

**A) Notificaciones locales desde JSON**
1. Ejecuta la app en dispositivo/emulador:
```powershell
flutter pub get
flutter run
```
2. Llama desde la UI `NotificationService().sendAlertsFromLocalJson(context)` para disparar las 3 notificaciones.

**B) Envío desde backend (FCM)**
1. Asegúrate de `google-services.json` en `android/app/` y la variable `GOOGLE_APPLICATION_CREDENTIALS` apuntando al service account.
2. Obtén token en cliente:
```dart
final token = await FirebaseMessaging.instance.getToken();
print('FCM token: $token');
```
3. En backend (PowerShell):
```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS='C:\path\to\serviceAccountKey.json'
node backend/src/fcm_sender.js
```

---

## Recursos
- FlutterFire: https://firebase.flutter.dev/
- firebase-admin (Node): https://firebase.google.com/docs/admin/setup
- flutter_local_notifications: https://pub.dev/packages/flutter_local_notifications

---

*Fin del documento.*
