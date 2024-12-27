import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Helper {
  static void enterFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [], // Empty list to hide all overlays
    );
  }

  static String toFormattedTime(int timeInSeconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeInSeconds * 1000);
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  static String getDayOfWeek(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000));
    return DateFormat('EEEE').format(dateTime);
  }

  static String concatIconUrl(String symbol) {
    if (kDebugMode) {
      print('symbol$symbol');
    }
    return 'https://openweathermap.org/img/wn/$symbol@2x.png';
  }
}

extension TimestampFormatter on int {
  String toFormattedTime() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat('HH:mm').format(dateTime);
  }
}

Future<bool> checkNetworkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.ethernet)) {
    return true;
  }

  return false;
}
