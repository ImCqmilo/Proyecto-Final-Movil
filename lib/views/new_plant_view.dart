import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hola_mundo/main.dart'; // importa el themeNotifier

class NewPlantView extends StatefulWidget {
  const NewPlantView({super.key});

  @override
  State<NewPlantView> createState() => _NewPlantViewState();
}

class _NewPlantViewState extends State<NewPlantView> {
  Uint8List? _cilantroImageBytes;
  Uint8List? _perejilImageBytes;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isCilantro) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        if (isCilantro) {
          _cilantroImageBytes = bytes;
        } else {
          _perejilImageBytes = bytes;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Planta'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Nombre de la planta'),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Índices (Humedad y Temperatura)',
              ),
            ),
            const SizedBox(height: 24),
            const Text('Cilantro'),
            const SizedBox(height: 8),
              _cilantroImageBytes != null
                ? Image.memory(_cilantroImageBytes!, height: 100)
                : const Placeholder(fallbackHeight: 100),
            ElevatedButton(
              onPressed: () => _pickImage(true),
              child: const Text('Seleccionar imagen de Cilantro'),
            ),
            const SizedBox(height: 24),
            const Text('Perejil'),
            const SizedBox(height: 8),
            _perejilImageBytes != null
                ? Image.memory(_perejilImageBytes!, height: 100)
                : const Placeholder(fallbackHeight: 100),
            ElevatedButton(
              onPressed: () => _pickImage(false),
              child: const Text('Seleccionar imagen de Perejil'),
            ),
          ],
        ),
      ),
    );
  }
}
