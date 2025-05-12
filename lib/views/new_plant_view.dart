import 'package:flutter/material.dart';

class NewPlantView extends StatelessWidget {
  const NewPlantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Planta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nombre de la planta')),
            const SizedBox(height: 12),
            const Placeholder(fallbackHeight: 100), // previsualización de imagen
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Índices (Humedad y Temperatura)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
