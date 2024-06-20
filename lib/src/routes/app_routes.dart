import 'package:flutter/material.dart';
import 'package:access_control/src/Configuration/configuration.dart';
import 'package:access_control/src/Home/home.dart';
import 'package:access_control/src/login/screens/login_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> appRoutes = {
    'home': (_) => const HomeScreen(),
    'login': (_) => const LoginScreen(),
    'configuration': (_) => const ConfigurationScreen(),
  };
}
