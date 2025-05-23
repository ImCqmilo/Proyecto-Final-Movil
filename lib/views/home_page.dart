import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.push('/login'),
            child: const Text('Ir a Login'),
          ),
          ElevatedButton(
              onPressed: () => context.pushNamed('plants'),
              child: const Text('Plantas a Cuidar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.pushNamed('newPlant'),
              child: const Text('Nueva Planta'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.pushNamed('status'),
              child: const Text('Gráfico de Status'),
            ),
             ElevatedButton(
              onPressed: () => context.pushNamed('categorias'),
              child: const Text('categorias'),
            ),
        ],
      ),
    );
  }
}
