import 'package:access_control/src/Routes/app_routes.dart';
import 'package:access_control/src/Themes/app_theme.dart';
import 'package:access_control/src/Providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final String initialRoute;

  const App({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ConfigurationFormProvider()),
        ChangeNotifierProvider(create: (_) => IdentificationProvider()),
        ChangeNotifierProvider(create: (_) => IncomesProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Control de accesos',
        initialRoute: initialRoute,
        routes: AppRoutes.appRoutes,
        theme: AppTheme.mainTheme,
      ),
    );
  }
}
