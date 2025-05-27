import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/main.dart';

class PlantsView extends StatelessWidget {
  const PlantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/homepage'), // o la ruta principal que tengas
        ),
        title: const Text('Plantas a Cuidar'),
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
      body: ListView(
        children: const [
          PlantItem(name: 'Cilantro', lastWatered: '12:00 pm'),
          PlantItem(name: 'Perejil', lastWatered: '29/04/25'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/new-plant'), // Agrega lógica para crear nueva planta
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PlantItem extends StatelessWidget {
  final String name;
  final String lastWatered;

  const PlantItem({super.key, required this.name, required this.lastWatered});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/plant.png'), // asegúrate de tener esta imagen
      title: Text(name),
      subtitle: Text('Última vez regado: $lastWatered'),
      trailing: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {}, // Ir a vista de detalles
      ),
    );
  }
}
