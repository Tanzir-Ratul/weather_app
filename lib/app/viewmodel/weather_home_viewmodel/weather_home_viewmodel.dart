import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/app/data/data_source/network/response/status.dart';
import 'package:weather_app/app/data/model/current_weather_data.dart';
import 'package:weather_app/app/data/model/forecast_data.dart';

import '../../data/repository/weather_repo.dart';
import '../../ui/components/CustomSnackbar.dart';
import '../../utils/helper_function.dart';

class WeatherHomeController extends GetxController with WidgetsBindingObserver {
  WeatherRepository repository;

  WeatherHomeController(this.repository);

  var weatherData = CurrentWeatherData().obs;
  var forecastData = ForecastData().obs;
  var isLoading = false.obs;

  var lat = 54.496648.obs;
  var lon = (-7.312268).obs;
  RxBool isDialogOpen = false.obs;
  final locationMessage = "Getting Location...".obs;
  final currentPosition = Rx<Position?>(null);

  final isCelsius = true.obs;
  final temperatureCelsius = 0.0.obs;
  final temperatureFahrenheit = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    print('connectivity: ${await checkNetworkConnectivity()}');
    if (await checkNetworkConnectivity()) {
      getLocationAndFetchWeather();
    } else {
      offlineDataRetrieve();
    }
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('inside resume');
      }
      getLocationAndFetchWeather();
    }
  }

  Future<void> getLocationAndFetchWeather() async {
    isLoading.value = true;
    try {
      await _getLocation();
      if (currentPosition.value != null) {
        lat.value = currentPosition.value!.latitude;
        lon.value = currentPosition.value!.longitude;
        await Future.wait([getWeatherData(), getForecastData()]);
      }
    } catch (e) {
      locationMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMessage.value = 'Location services are disabled.';
      await locationServiceSettingsDialog();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMessage.value = 'Location permissions are denied';
        Get.snackbar(
          'Location Permissions Denied',
          'Please grant location permissions to use this feature.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationMessage.value = 'Location permissions are permanently denied.';
      openAppSettings();
      return;
    }

    try {
      currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      locationMessage.value = 'Location obtained.';
    } catch (e) {
      locationMessage.value = 'Error getting location: $e';
    }
  }

  Future<void> locationPermissionSettingsDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      useRootNavigator: false, // Add this line
      builder: (BuildContext context) {
        if (kDebugMode) {
          print('inside dialog');
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Location Permissions Denied Forever'),
            content: const Text(
                'Location permissions are permanently denied. Please enable them in app settings to use this feature.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> locationServiceSettingsDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Location Services Disabled'),
            content: const Text(
                'Location services are disabled. Please enable them to use this feature.'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  if (Platform.isAndroid) {
                    await Geolocator.openLocationSettings();
                  } else if (Platform.isIOS) {
                    Uri url = Uri.parse('app-settings:');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      Get.snackbar('Error', 'Could not open app settings.');
                    }
                  }
                },
                child: const Text('Enable Location'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getWeatherData() async {
    try {
      isLoading.value = true;
      if (kDebugMode) {
        print('lat ${lat.value}--${lon.value}');
      }
      final data = {
        'lat': lat.value,
        'lon': lon.value,
        'units': 'metric',
        'appid': dotenv.env['API_KEY'] ?? "",
      };
      final response = await repository.fetchCurrentWeather(data);
      if (kDebugMode) {
        print('responseWeather: ${response.data?.toJson()}');
      }
      if (response.status == Status.COMPLETED && response.statusCode == 200) {
        if (response.data != null) {
          weatherData.value = response.data ?? CurrentWeatherData();
          temperatureCelsius.value = weatherData.value.main?.temp ?? 0;
        }
      } else {
        CustomSnackbar.showSnackbar(
            title: "Error", message: '${response.message}');
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(title: "Error", message: '$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getForecastData() async {
    try {
      final data = {
        'lat': lat.value,
        'lon': lon.value,
        'units': 'metric',
        'appid': dotenv.env['API_KEY'] ?? "",
      };
      final response = await repository.fetchForecastData(data);
      if (kDebugMode) {
        print('responseWeather: ${response.data?.toJson()}');
      }
      if (response.status == Status.COMPLETED && response.statusCode == 200) {
        if (response.data != null) {
          forecastData.value = response.data ?? ForecastData();
        }
      } else {
        CustomSnackbar.showSnackbar(
            title: "Error", message: '${response.message}');
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(title: "Error", message: '$e');
    }
  }

  double get displayedTemperature {
    return isCelsius.value
        ? temperatureCelsius.value
        : temperatureFahrenheit.value;
  }

  // Function to toggle between Celsius and Fahrenheit
  void toggleTemperatureUnit() {
    isCelsius.value = !isCelsius.value;
    if (isCelsius.value) {
      temperatureCelsius.value = (temperatureFahrenheit.value - 32) * 5 / 9;
    } else {
      temperatureFahrenheit.value = (temperatureCelsius.value * 9 / 5) + 32;
    }
  }

  void offlineDataRetrieve() {}
}
