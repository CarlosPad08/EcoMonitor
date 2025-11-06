import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/presentation/pages/home_page.dart';
import 'package:eco_monitor/features/weather/presentation/pages/alerts_page.dart';
import 'package:eco_monitor/features/weather/presentation/pages/favorites_page.dart';
import 'package:eco_monitor/features/weather/presentation/pages/settings_page.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  
  const BottomNavigation({
    super.key,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF4A148C), // Púrpura oscuro
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: 'assets/images/home_icono.png',
            isSelected: currentIndex == 0,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          _buildNavItem(
            icon: 'assets/images/nube_icono.png',
            isSelected: currentIndex == 1,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
          _buildNavItem(
            icon: 'assets/images/mi_notification_icono.png',
            isSelected: currentIndex == 2,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AlertsPage()),
              );
            },
          ),
          _buildNavItem(
            icon: 'assets/images/list_icono.png',
            isSelected: currentIndex == 3,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
