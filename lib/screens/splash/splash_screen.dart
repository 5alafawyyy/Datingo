import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  static const String routeName = '/Splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => const SplashScreen()),
    );
  } 
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child:  Text('Splash Screen')),
    );
  }
}