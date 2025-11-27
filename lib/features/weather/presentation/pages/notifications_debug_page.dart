import 'package:flutter/material.dart';
import 'package:eco_monitor/core/notifications/notification_service.dart';

/// Debug/Test screen for notifications
/// Shows alerts loaded from JSON and allows manual testing
class NotificationsDebugPage extends StatefulWidget {
  const NotificationsDebugPage({super.key});

  @override
  State<NotificationsDebugPage> createState() => _NotificationsDebugPageState();
}

class _NotificationsDebugPageState extends State<NotificationsDebugPage> {
  final _notificationService = NotificationService();
  bool _autoNotificationsEnabled = true;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _toggleAutoNotifications() async {
    setState(() {
      _autoNotificationsEnabled = !_autoNotificationsEnabled;
    });
    
    if (_autoNotificationsEnabled) {
      _notificationService.resumeAutoNotifications();
      _showSnackBar('✅ Auto-notifications resumed');
    } else {
      _notificationService.stopAutoNotifications();
      _showSnackBar('⏹️  Auto-notifications stopped');
    }
  }

  void _showAllAlerts() {
    _notificationService.showAllAlerts();
    _showSnackBar('✅ Showing all alerts (check logs)');
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final alerts = _notificationService.getLoadedAlerts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔔 Notificaciones (Debug)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estado de notificaciones
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estado de Notificaciones',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          _autoNotificationsEnabled ? Icons.check_circle : Icons.pause_circle,
                          color: _autoNotificationsEnabled ? Colors.green : Colors.orange,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _autoNotificationsEnabled
                                    ? 'Auto-notificaciones ACTIVADAS'
                                    : 'Auto-notificaciones PAUSADAS',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _autoNotificationsEnabled
                                    ? 'Se mostrarán cada 30 segundos'
                                    : 'Pausadas hasta que las reactivees',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: const Text('Activar/Desactivar Auto-notificaciones'),
                      value: _autoNotificationsEnabled,
                      onChanged: (_) => _toggleAutoNotifications(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botones de prueba
            const Text(
              'Controles de Prueba',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showAllAlerts,
              icon: const Icon(Icons.notifications),
              label: const Text('Mostrar Todas las Alertas'),
            ),
            const SizedBox(height: 16),

            // Alertas cargadas
            Text(
              'Alertas Disponibles (${alerts.length})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (alerts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('⚠️  No alerts loaded'),
              )
            else
              ...alerts.map((alert) => _buildAlertCard(alert)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(dynamic alert) {
    final colorBg = alert.severity == 'high' ? Colors.red[50] : Colors.orange[50];
    final colorBorder = alert.severity == 'high' ? Colors.red : Colors.orange;

    return Card(
      color: colorBg,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorBorder, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alert.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              alert.message,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(alert.severity.toUpperCase()),
                  backgroundColor: colorBorder.withOpacity(0.3),
                  labelStyle: const TextStyle(fontSize: 10),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(alert.type),
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  labelStyle: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                _notificationService.showAlertById(alert.id);
                _showSnackBar('Mostrado: ${alert.title}');
              },
              icon: const Icon(Icons.notifications_active, size: 16),
              label: const Text('Mostrar Alerta'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
