class WeatherData {
  final String id;
  final DateTime createdAt;
  final double temperature;
  final double humidity;
  final double pressure;
  final double? windSpeed;
  final double? windDirection;
  final double? rainfall;

  const WeatherData({
    required this.id,
    required this.createdAt,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    this.windSpeed,
    this.windDirection,
    this.rainfall,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      id: json['entry_id']?.toString() ?? '',
      createdAt: DateTime.parse(json['created_at']),
      temperature: double.tryParse(json['field1']?.toString() ?? '0') ?? 0.0,
      humidity: double.tryParse(json['field2']?.toString() ?? '0') ?? 0.0,
      pressure: double.tryParse(json['field3']?.toString() ?? '0') ?? 0.0,
      windSpeed: double.tryParse(json['field4']?.toString() ?? ''),
      windDirection: double.tryParse(json['field5']?.toString() ?? ''),
      rainfall: double.tryParse(json['field6']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry_id': id,
      'created_at': createdAt.toIso8601String(),
      'field1': temperature,
      'field2': humidity,
      'field3': pressure,
      'field4': windSpeed,
      'field5': windDirection,
      'field6': rainfall,
    };
  }

  WeatherData copyWith({
    String? id,
    DateTime? createdAt,
    double? temperature,
    double? humidity,
    double? pressure,
    double? windSpeed,
    double? windDirection,
    double? rainfall,
  }) {
    return WeatherData(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      rainfall: rainfall ?? this.rainfall,
    );
  }
}
