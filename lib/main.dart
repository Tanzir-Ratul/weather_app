import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/ui/weather_home/weather_screen.dart';

import 'app/binding/initialBinding.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/routes_path.dart';
import 'app/utils/helper_function.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
  }
  // Lock orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Enter full screen mode
  Helper.enterFullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      locale: const Locale("en", "US"),
      fallbackLocale: const Locale("en", "US"),
      initialRoute: Routes.initial,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.leftToRight,
      getPages: AppRoutes.pages,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );

  }
}


