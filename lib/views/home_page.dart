import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/main.dart';
import 'package:hola_mundo/services/auth_service.dart'; // Asegúrate de importar donde está el themeNotifier

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Inicio'),
      actions: [
        IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Cerrar sesión',
      onPressed: () async {
        final token = await AuthService().getToken();
        if (token != null) {
          await AuthService().logout();
        }
        if (!context.mounted) return;
        context.go('/login');
      },
    ),
  ValueListenableBuilder<ThemeMode>(
    valueListenable: themeNotifier,
    builder: (context, mode, _) {
      return Row(
        children: [
          Icon(
            mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
          ),
          Switch(
            value: mode == ThemeMode.dark,
            onChanged: (value) {
              themeNotifier.value =
                  value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
               ],
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/plants'),
            child: const Text("Plantas"),
          ),
          const SizedBox(height: 20),
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