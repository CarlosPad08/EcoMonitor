# 📦 Tutorial: Compilar y Compartir EcoMonitor

Este tutorial te guiará paso a paso para compilar la aplicación EcoMonitor y compartirla con otras personas.

## 📋 Requisitos Previos

- Flutter SDK instalado (versión >=3.0.0)
- Node.js instalado (versión >=18.0.0) - Solo si necesitas el backend
- Python 3 - Para servir la aplicación (opcional, hay otras opciones)

## 🚀 Opción 1: Compilar para Web (Recomendado)

### Paso 1: Compilar la aplicación

Abre una terminal en la carpeta del proyecto y ejecuta:

```bash
cd /home/jersson/Documentos/ecomonitor/EcoMonitor
flutter build web
```

Este comando creará una carpeta `build/web` con todos los archivos necesarios para la aplicación web.

**Tiempo estimado:** 1-3 minutos (la primera vez puede tardar más)

### Paso 2: Servir la aplicación

Tienes varias opciones para servir la aplicación:

#### Opción A: Usar Python (Simple y rápido)

```bash
cd build/web
python3 -m http.server 8080
```

La aplicación estará disponible en: `http://localhost:8080`

#### Opción B: Usar Node.js (http-server)

Si tienes Node.js instalado:

```bash
# Instalar http-server globalmente (solo una vez)
npm install -g http-server

# Servir la aplicación
cd build/web
http-server -p 8080
```

#### Opción C: Usar Flutter directamente (con hot reload)

```bash
# Configurar Edge como navegador (si usas Edge)
export CHROME_EXECUTABLE=/usr/bin/microsoft-edge

# Ejecutar en modo desarrollo
flutter run -d web --web-port=8080
```

### Paso 3: Compartir en tu red local

Para que otras personas en tu misma red puedan acceder:

1. **Obtén tu dirección IP local:**
   ```bash
   # En Linux/Mac
   hostname -I
   # o
   ip addr show | grep "inet "
   
   # En Windows
   ipconfig
   ```

2. **Inicia el servidor escuchando en todas las interfaces:**
   ```bash
   # Con Python
   cd build/web
   python3 -m http.server 8080 --bind 0.0.0.0
   
   # Con http-server (Node.js)
   http-server -p 8080 -a 0.0.0.0
   ```

3. **Comparte la URL:**
   - Otras personas pueden acceder usando: `http://TU_IP:8080`
   - Ejemplo: `http://192.168.1.100:8080`

## 🌐 Opción 2: Desplegar en un Servidor Web

### Para servidores Apache/Nginx

1. **Compila la aplicación:**
   ```bash
   flutter build web --release
   ```

2. **Sube los archivos:**
   - Copia todo el contenido de `build/web` a la carpeta pública de tu servidor web
   - Ejemplo: `/var/www/html/` o `/var/www/ecomonitor/`

3. **Configura el servidor:**
   
   **Para Nginx**, crea un archivo de configuración:
   ```nginx
   server {
       listen 80;
       server_name tu-dominio.com;
       root /var/www/ecomonitor;
       index index.html;

       location / {
           try_files $uri $uri/ /index.html;
       }
   }
   ```

   **Para Apache**, crea un archivo `.htaccess` en `build/web`:
   ```apache
   RewriteEngine On
   RewriteBase /
   RewriteRule ^index\.html$ - [L]
   RewriteCond %{REQUEST_FILENAME} !-f
   RewriteCond %{REQUEST_FILENAME} !-d
   RewriteRule . /index.html [L]
   ```

### Para servicios de hosting estático

Puedes subir la carpeta `build/web` a servicios como:
- **Netlify**: Arrastra y suelta la carpeta `build/web`
- **Vercel**: `vercel build/web`
- **GitHub Pages**: Sube los archivos a un repositorio y activa GitHub Pages
- **Firebase Hosting**: `firebase deploy`

## 🔧 Opción 3: Compartir como Archivo

### Crear un paquete portable

1. **Compila la aplicación:**
   ```bash
   flutter build web --release
   ```

2. **Comprime la carpeta:**
   ```bash
   cd build
   tar -czf ecomonitor-web.tar.gz web/
   # o en Windows, usa 7-Zip o WinRAR para comprimir la carpeta 'web'
   ```

3. **Comparte el archivo:**
   - Envía el archivo comprimido a otras personas
   - Ellos pueden descomprimirlo y abrir `index.html` en su navegador
   - **Nota:** Algunas funcionalidades pueden no funcionar sin un servidor web

## 📱 Opción 4: Compilar para Android/iOS

### Para Android:

```bash
flutter build apk --release
# El archivo estará en: build/app/outputs/flutter-apk/app-release.apk
```

### Para iOS (solo en Mac):

```bash
flutter build ios --release
```

## 🛠️ Solución de Problemas

### Problema: "No supported devices found with name or id matching 'web'"

**Solución:**
```bash
flutter config --enable-web
```

### Problema: Chrome/Edge no encontrado

**Solución:**
```bash
# Para Edge
export CHROME_EXECUTABLE=/usr/bin/microsoft-edge

# Para Chrome
export CHROME_EXECUTABLE=/usr/bin/google-chrome

# Para Chromium
export CHROME_EXECUTABLE=/usr/bin/chromium
```

### Problema: El servidor no es accesible desde otros dispositivos

**Solución:**
- Verifica que el firewall permita conexiones en el puerto 8080
- Asegúrate de usar `--bind 0.0.0.0` o `-a 0.0.0.0`
- Verifica que todos los dispositivos estén en la misma red

### Problema: La aplicación no carga correctamente

**Solución:**
- Asegúrate de compilar con `flutter build web --release` para producción
- Verifica que todos los archivos en `build/web` estén presentes
- Limpia el caché: `flutter clean && flutter pub get`

## 📝 Comandos Rápidos de Referencia

```bash
# Compilar para web
flutter build web

# Compilar para producción (optimizado)
flutter build web --release

# Limpiar y recompilar
flutter clean
flutter pub get
flutter build web

# Servir con Python
cd build/web && python3 -m http.server 8080

# Servir con Python (accesible en red)
cd build/web && python3 -m http.server 8080 --bind 0.0.0.0

# Ver la aplicación en el navegador
flutter run -d web
```

## 🔐 Notas de Seguridad

- Si compartes la aplicación en una red pública, considera usar HTTPS
- Para producción, siempre usa `flutter build web --release`
- No compartas archivos de configuración con API keys o credenciales

## 📞 Soporte

Si tienes problemas durante la compilación o despliegue, verifica:
1. Que Flutter esté actualizado: `flutter --version`
2. Que todas las dependencias estén instaladas: `flutter pub get`
3. Los logs de compilación para errores específicos

---

**¡Listo!** Ahora puedes compartir tu aplicación EcoMonitor con otras personas. 🌤️

