import 'package:access_control/src/Configuration/configuration.dart';
import 'package:access_control/src/Home/screens/main_screen.dart';
import 'package:access_control/src/Providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:access_control/src/Home/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Control de accesos'),
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: true,
    );

  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    int currentIndex = uiProvider.selectedMenuOpt;

    switch(currentIndex){
      case 0:
        return const MainScreen();
      case 1:
        return const ConfigurationScreen();
      default:
        return const MainScreen();
    }
  }
}
