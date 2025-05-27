import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/planta_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hola_mundo/services/db_service.dart';
import 'package:hola_mundo/main.dart';

class NewPlantView extends StatefulWidget {
  const NewPlantView({super.key});

  @override
  State<NewPlantView> createState() => _NewPlantViewState();
}

class _NewPlantViewState extends State<NewPlantView> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _indicesController = TextEditingController(); 

  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _guardarPlanta() async {
  if (_formKey.currentState!.validate()) {
    final nuevaPlanta = Planta(
      nombre: _nombreController.text,
      descripcion: _indicesController.text,
      imagen: _imageBytes, 
    );

    await DBService.insertPlanta(nuevaPlanta);
    if (!mounted) return;
    context.pop();
    }
  }
  @override
  void dispose() {
    _nombreController.dispose();
    _indicesController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Planta'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre de la planta'),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _indicesController,
                decoration: const InputDecoration(labelText: 'Indices (Humedad y Temperatura)'),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 24),
              const Text('Imagen de la Planta'),
              const SizedBox(height: 8),
              _imageBytes != null
                  ? Image.memory(_imageBytes!, height: 100)
                  : const Placeholder(fallbackHeight: 100),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Seleccionar Imagen'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarPlanta,
                child: const Text('Guardar Planta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
