import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hola_mundo/main.dart'; // importa el themeNotifier

class NewPlantView extends StatefulWidget {
  const NewPlantView({super.key});

  @override
  State<NewPlantView> createState() => _NewPlantViewState();
}

class _NewPlantViewState extends State<NewPlantView> {
  File? _cilantroImage;
  File? _perejilImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isCilantro) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isCilantro) {
          _cilantroImage = File(pickedFile.path);
        } else {
          _perejilImage = File(pickedFile.path);
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
            _cilantroImage != null
                ? Image.file(_cilantroImage!, height: 100)
                : const Placeholder(fallbackHeight: 100),
            ElevatedButton(
              onPressed: () => _pickImage(true),
              child: const Text('Seleccionar imagen de Cilantro'),
            ),
            const SizedBox(height: 24),
            const Text('Perejil'),
            const SizedBox(height: 8),
            _perejilImage != null
                ? Image.file(_perejilImage!, height: 100)
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
