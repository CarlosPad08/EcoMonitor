import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsModel {
  final ThemeMode themeMode;
  final bool useCelsius;
  final bool useHpa;

  SettingsModel({
    required this.themeMode,
    required this.useCelsius,
    required this.useHpa,
  });

  SettingsModel copyWith({
    ThemeMode? themeMode,
    bool? useCelsius,
    bool? useHpa,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      useCelsius: useCelsius ?? this.useCelsius,
      useHpa: useHpa ?? this.useHpa,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsModel> {
  SettingsNotifier()
      : super(SettingsModel(themeMode: ThemeMode.light, useCelsius: true, useHpa: true)) {
    // Settings loaded in-memory; no persistent storage for now
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    // TODO: Persist to SharedPreferences when re-added
    state = state.copyWith(themeMode: mode);
  }

  // Mantener compatibilidad con código existente
  bool get isDarkMode => state.themeMode == ThemeMode.dark;
  
  Future<void> toggleDarkMode(bool value) async {
    setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTemperatureUnit(bool useCelsius) async {
    // TODO: Persist to SharedPreferences when re-added
    state = state.copyWith(useCelsius: useCelsius);
  }

  Future<void> togglePressureUnit(bool useHpa) async {
    // TODO: Persist to SharedPreferences when re-added
    state = state.copyWith(useHpa: useHpa);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsModel>(
        (ref) => SettingsNotifier());

