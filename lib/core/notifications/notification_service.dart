import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Modelo simple para una alerta
class AlertNotification {
  final String id;
  final String type;
  final String title;
  final String message;
  final String severity;
  final String timestamp;

  AlertNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.severity,
    required this.timestamp,
  });

  factory AlertNotification.fromJson(Map<String, dynamic> json) {
    return AlertNotification(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
      timestamp: json['timestamp'] as String,
    );
  }
}

/// NotificationService: Maneja notificaciones locales desde JSON
class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  List<AlertNotification> _loadedAlerts = [];
  Timer? _autoNotificationTimer;
  int _notificationCounter = 0;

  /// Inicializar el servicio de notificaciones
  Future<void> init() async {
    debugPrint('🔔 Initializing NotificationService...');
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'eco_monitor_alerts',
      'EcoMonitor Alertas',
      description: 'Notificaciones de alertas meteorológicas',
      importance: Importance.high,
      playSound: true,
    );
    
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    
    await _loadAlertsFromJson();
    _scheduleAutoNotifications();
  }

  /// Cargar alertas desde assets/data/alerts.json
  Future<void> _loadAlertsFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/alerts.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      
      _loadedAlerts = jsonData
          .map((item) => AlertNotification.fromJson(item as Map<String, dynamic>))
          .toList();
      
      debugPrint('✅ Loaded ${_loadedAlerts.length} alerts from JSON');
      for (final alert in _loadedAlerts) {
        debugPrint('   - ${alert.title}');
      }
    } catch (e) {
      debugPrint('❌ Error loading alerts: $e');
    }
  }

  /// Programar notificaciones automáticas
  void _scheduleAutoNotifications() {
    _autoNotificationTimer = Timer(const Duration(seconds: 30), () {
      _showNextNotification();
    });
    debugPrint('📅 Auto-notifications scheduled for 30s from now');
  }

  /// Mostrar la siguiente notificación
  void _showNextNotification() {
    if (_loadedAlerts.isEmpty) {
      debugPrint('⚠️  No alerts to show');
      return;
    }

    final alert = _loadedAlerts[_notificationCounter % _loadedAlerts.length];
    _displayNotification(alert);
    debugPrint('📬 Showing notification: ${alert.title}');
    
    _notificationCounter++;

    _autoNotificationTimer = Timer(const Duration(seconds: 30), () {
      _showNextNotification();
    });
  }

  /// Mostrar una notificación en la barra del sistema
  Future<void> _displayNotification(AlertNotification alert) async {
    try {
      await _flutterLocalNotificationsPlugin.show(
        alert.id.hashCode,
        alert.title,
        alert.message,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'eco_monitor_alerts',
            'EcoMonitor Alertas',
            channelDescription: 'Notificaciones de alertas meteorológicas',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            showWhen: true,
            color: _getColorBySeverity(alert.severity),
          ),
        ),
      );
      debugPrint('✅ Notification displayed in system tray');
    } catch (e) {
      debugPrint('❌ Error displaying notification: $e');
    }
  }

  /// Obtener color según severidad
  Color _getColorBySeverity(String severity) {
    if (severity == 'high') {
      return const Color(0xFFE53935); // Rojo
    } else if (severity == 'medium') {
      return const Color(0xFFFFA726); // Naranja
    }
    return const Color(0xFF66BB6A); // Verde
  }

  /// Mostrar una alerta manualmente
  void showAlertById(String alertId) {
    try {
      final alert = _loadedAlerts.firstWhere((a) => a.id == alertId);
      _displayNotification(alert);
    } catch (e) {
      debugPrint('❌ Alert not found: $alertId');
    }
  }

  /// Mostrar todas las alertas
  Future<void> showAllAlerts() async {
    for (final alert in _loadedAlerts) {
      await _displayNotification(alert);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  /// Obtener todas las alertas
  List<AlertNotification> getLoadedAlerts() => _loadedAlerts;

  /// Detener notificaciones
  void stopAutoNotifications() {
    _autoNotificationTimer?.cancel();
    debugPrint('⏹️  Auto-notifications stopped');
  }

  /// Reanudar notificaciones
  void resumeAutoNotifications() {
    _scheduleAutoNotifications();
  }

  /// Dispose
  void dispose() {
    _autoNotificationTimer?.cancel();
  }
}
