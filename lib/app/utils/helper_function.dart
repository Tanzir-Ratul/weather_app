import 'package:flutter/services.dart';

class Helper{
  static void enterFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [], // Empty list to hide all overlays
    );
  }
}


