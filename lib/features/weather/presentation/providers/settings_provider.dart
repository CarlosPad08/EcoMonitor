import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel {
  final bool isDarkMode;
  final bool useCelsius;
  final bool useHpa;

  SettingsModel({
    required this.isDarkMode,
    required this.useCelsius,
    required this.useHpa,
  });

  SettingsModel copyWith({
    bool? isDarkMode,
    bool? useCelsius,
    bool? useHpa,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      useCelsius: useCelsius ?? this.useCelsius,
      useHpa: useHpa ?? this.useHpa,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsModel> {
  SettingsNotifier()
      : super(SettingsModel(isDarkMode: false, useCelsius: true, useHpa: true)) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    state = SettingsModel(
      isDarkMode: prefs.getBool('dark_mode') ?? false,
      useCelsius: prefs.getBool('use_celsius') ?? true,
      useHpa: prefs.getBool('use_hpa') ?? true,
    );
  }

  Future<void> toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
    state = state.copyWith(isDarkMode: value);
  }

  Future<void> toggleTemperatureUnit(bool useCelsius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_celsius', useCelsius);
    state = state.copyWith(useCelsius: useCelsius);
  }

  Future<void> togglePressureUnit(bool useHpa) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_hpa', useHpa);
    state = state.copyWith(useHpa: useHpa);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsModel>(
        (ref) => SettingsNotifier());

