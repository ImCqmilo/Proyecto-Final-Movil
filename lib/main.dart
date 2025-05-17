import 'package:flutter/material.dart';
import 'package:hola_mundo/routes/app_routes.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _){
    return MaterialApp.router(
      title: 'App sistema de Riego',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData.dark(),
      themeMode: currentMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
     
        );
      },
    );
  }
}


