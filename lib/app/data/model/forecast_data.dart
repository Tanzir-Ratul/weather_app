
class ForecastDataDTO {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<ListElement>? list;
  final City? city;

  ForecastDataDTO({
     this.cod,
     this.message,
     this.cnt,
     this.list,
     this.city,
  });

  factory ForecastDataDTO.fromJson(Map<String, dynamic> json) => ForecastDataDTO(
    cod: json['cod'] as String,
    message: json['message'] as int,
    cnt: json['cnt'] as int,
    list: List<ListElement>.from(
        json['list'].map((x) => ListElement.fromJson(x))),
    city: City.fromJson(json['city']),
  );

  Map<String, dynamic> toJson() => {
    'cod': cod,
    'message': message,
    'cnt': cnt,
    'list': List<dynamic>.from(list!.map((x) => x.toJson())),
    'city': city?.toJson(),
  };
}

class City {
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  City({
     this.id,
     this.name,
     this.coord,
     this.country,
     this.population,
     this.timezone,
     this.sunrise,
     this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['id'] as int,
    name: json['name'] as String,
    coord: Coord.fromJson(json['coord']),
    country: json['country'] as String,
    population: json['population'] as int,
    timezone: json['timezone'] as int,
    sunrise: json['sunrise'] as int,
    sunset: json['sunset'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'coord': coord?.toJson(),
    'country': country,
    'population': population,
    'timezone': timezone,
    'sunrise': sunrise,
    'sunset': sunset,
  };
}

class Coord {
  final double? lat;
  final double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lon'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lon': lon,
  };
}

class ListElement {
  final int? dt;
  final MainClass? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final num? pop;
  final Sys? sys;
  final String? dtTxt;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json['dt'] as int,
    main: MainClass.fromJson(json['main']),
    weather: List<Weather>.from(
        json['weather'].map((x) => Weather.fromJson(x))),
    clouds: Clouds.fromJson(json['clouds']),
    wind: Wind.fromJson(json['wind']),
    visibility: json['visibility'] as int,
    pop: json['pop'] as num,
    sys: Sys.fromJson(json['sys']),
    dtTxt: json['dt_txt'] as String,
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'main': main?.toJson(),
    'weather': List<dynamic>.from(weather!.map((x) => x.toJson())),
    'clouds': clouds?.toJson(),
    'wind': wind?.toJson(),
    'visibility': visibility,
    'pop': pop,
    'sys': sys?.toJson(),
    'dt_txt': dtTxt,
  };
}

class MainClass {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  MainClass({
     this.temp,
     this.feelsLike,
     this.tempMin,
     this.tempMax,
     this.pressure,
     this.seaLevel,
     this.grndLevel,
     this.humidity,
     this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: (json['temp'] as num).toDouble(),
    feelsLike: (json['feels_like'] as num).toDouble(),
    tempMin: (json['temp_min'] as num).toDouble(),
    tempMax: (json['temp_max'] as num).toDouble(),
    pressure: json['pressure'] as int,
    seaLevel: json['sea_level'] as int,
    grndLevel: json['grnd_level'] as int,
    humidity: json['humidity'] as int,
    tempKf: (json['temp_kf'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
    'humidity': humidity,
    'temp_kf': tempKf,
  };
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json['all'] as int,
  );

  Map<String, dynamic> toJson() => {
    'all': all,
  };
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: (json['speed'] as num).toDouble(),
    deg: json['deg'] as int,
    gust: (json['gust'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'speed': speed,
    'deg': deg,
    'gust': gust,
  };
}

class Sys {
  final String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: json['pod'] as String,
  );

  Map<String, dynamic> toJson() => {
    'pod': pod,
  };
}

