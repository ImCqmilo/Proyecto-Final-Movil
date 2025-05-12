import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gráfico de Status')),
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
