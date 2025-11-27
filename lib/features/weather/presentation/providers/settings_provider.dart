import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // Settings loaded in-memory; no persistent storage for now
  }

  Future<void> toggleDarkMode(bool value) async {
    // TODO: Persist to SharedPreferences when re-added
    state = state.copyWith(isDarkMode: value);
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

