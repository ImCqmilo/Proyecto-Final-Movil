import 'package:flutter/material.dart';
import 'package:hola_mundo/main.dart';
import 'package:go_router/go_router.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
         icon: const Icon(Icons.arrow_back),
         onPressed: () {
            context.go('/homepage'); // Esto regresa a la vista anterior
         },
         ),
      title: const Text('Gráfico de Status'),
      actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Status Planta', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: 0.6, minHeight: 10),
            const SizedBox(height: 8),
            const Text('Humedad: 60%'),
            const Text('Temperatura: 15°'),
            const Text('Índice Luz: 20%'),
            const SizedBox(height: 20),
            const Text('Gráfico Visual Del Consumo'),
            const SizedBox(height: 8),
            Container(
              height: 200,
              color: Colors.grey[200],
              child: const Center(child: Text('Gráfico aquí')),
            ),
            
          ],
        ),
      ),
    );
  }
}
