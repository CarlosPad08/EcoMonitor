/*
 Example FCM sender using firebase-admin for Node.js
 Usage:
 1. Install: npm install firebase-admin
 2. Create a Firebase project and download the service account JSON
 3. Set environment variable: GOOGLE_APPLICATION_CREDENTIALS=/path/to/serviceAccountKey.json
 4. Run: node backend/src/fcm_sender.js
*/

const admin = require('firebase-admin');

// Initialize the SDK (will use GOOGLE_APPLICATION_CREDENTIALS env var)
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
  });
}

// Example: send notification to a device token
async function sendToToken(token, title, body, data = {}) {
  const message = {
    token,
    notification: {
      title,
      body,
    },
    data,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log('Successfully sent message:', response);
  } catch (error) {
    console.error('Error sending message:', error);
  }
}

// Example: send to a topic (e.g., "alerts_tulua")
async function sendToTopic(topic, title, body, data = {}) {
  const message = {
    topic,
    notification: {
      title,
      body,
    },
    data,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log('Successfully sent topic message:', response);
  } catch (error) {
    console.error('Error sending topic message:', error);
  }
}

// Demo usage if run directly
if (require.main === module) {
  const demoToken = process.env.FCM_TOKEN || '<DEVICE_TOKEN_HERE>';
  const demoTopic = 'alerts_tulua';

  // Send rain alert to topic
  sendToTopic(demoTopic, '🌧️ Lluvia fuerte detectada en Tulúa', 'Se ha detectado lluvia intensa en Tulúa. Evita desplazamientos.');

  // Optionally send direct to token
  // sendToToken(demoToken, '☀️ Alta radiación solar', 'Índice UV muy alto. Usa protector solar.');
}

module.exports = { sendToToken, sendToTopic };
