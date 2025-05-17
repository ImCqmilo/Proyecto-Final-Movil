import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/main.dart'; // Asegúrate de importar donde está el themeNotifier

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
      actions: [
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, currentMode, _) {
            return Switch(
              value: currentMode == ThemeMode.dark,
              onChanged: (value) {
                themeNotifier.value =
                    value ? ThemeMode.dark : ThemeMode.light;
              },
            );
          },
        ),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text("Ir a Login"),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.go('/plants'),
            child: const Text("Plantas a Cuidar"),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.go('/new-plant'),
            child: const Text("Nueva Planta"),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.go('/status'),
            child: const Text("Gráfico de Status"),
          ),
        ],
      ),
    ),
  );
 }
 }