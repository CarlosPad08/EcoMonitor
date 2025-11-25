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
