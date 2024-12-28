class WeatherDataClass {
  String? name;
  String? country;
  int? dt;
  double? temp;
  double? feelsLike;
  String? icon;
  String? description;
  double? sunrise;
  double? sunset;
  int? humidity;
  int? pressure;
  int? visibility;

  WeatherDataClass({
    this.name,
    this.country,
    this.dt,
    this.temp,
    this.feelsLike,
    this.icon,
    this.description,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.pressure,
    this.visibility,
  });

   Map<String, dynamic> toMap() {
    return {
      'name': name ?? 'unknown',
      'country': country ?? 'unknown',
      'dt': dt ?? 0,
      'temp': temp ?? 0.0,
      'feelsLike': feelsLike ?? 0.0,
      'icon': icon ?? '',
      'description': description ?? 'unknown',
      'sunrise': sunrise ?? 0.0,
      'sunset': sunset ?? 0.0,
      'humidity': humidity ?? 0,
      'pressure': pressure ?? 0,
      'visibility': visibility ?? 0,
    };
  }
  // Convert Map back to WeatherDataClass
  factory WeatherDataClass.fromMap(Map<String, dynamic> map) {
    return WeatherDataClass(
      name: map['name'],
      country: map['country'],
      dt: map['dt'],
      temp: map['temp'],
      feelsLike: map['feelsLike'],
      icon: map['icon'],
      description: map['description'],
      sunrise: map['sunrise'],
      sunset: map['sunset'],
      humidity: map['humidity'],
      pressure: map['pressure'],
      visibility: map['visibility'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'dt': dt,
      'temp': temp,
      'feelsLike': feelsLike,
      'icon': icon,
      'description': description,
      'sunrise': sunrise,
      'sunset': sunset,
      'humidity': humidity,
      'pressure': pressure,
      'visibility': visibility,
    };
  }


}
