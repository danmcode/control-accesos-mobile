import 'package:access_control/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String? storedToken = await secureStorage.read(key: 'token');

  String initialRoute = (storedToken == null) ? 'login' : 'home';

  runApp(App(
    initialRoute: initialRoute,
  ));
}
