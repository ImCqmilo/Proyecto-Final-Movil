import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/main.dart';
import 'package:hola_mundo/models/planta_model.dart';
import 'package:hola_mundo/services/db_service.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({super.key});

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  late Future<List<Planta>> _futurePlantas;

  @override
  void initState() {
    super.initState();
    _futurePlantas = DBService.getPlantas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plantas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/homepage');
          },
        ),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) {
              return Row(
                children: [
                  Icon(mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
                  Switch(
                    value: mode == ThemeMode.dark,
                    onChanged: (value) {
                      themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Planta>>(
        future: _futurePlantas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final plantas = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _futurePlantas = DBService.getPlantas();
              });
            },
            child: ListView.builder(
              itemCount: plantas.length,
              itemBuilder: (_, index) {
                final planta = plantas[index];
                return ListTile(
                  leading: planta.imagen != null
                      ? Image.memory(
                          planta.imagen!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/plant.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  title: Text(planta.nombre),
                  subtitle: Text('Descripcion de la planta: ${planta.descripcion}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [                
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          context.push('/plantas/edit/${planta.id}');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await DBService.deletePlanta(planta.id!);
                          setState(() {
                            _futurePlantas = DBService.getPlantas();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push('/plantas/newplant');
          setState(() {
            _futurePlantas = DBService.getPlantas();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
