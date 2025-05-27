import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hola_mundo/models/planta_model.dart';
import 'package:hola_mundo/services/db_service.dart';

class PlantsEditView extends StatefulWidget {
  final int id;

  const PlantsEditView({super.key, required this.id});

  @override
  State<PlantsEditView> createState() => _PlantsEditViewState();
}

class _PlantsEditViewState extends State<PlantsEditView> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  Uint8List? _imagen;
  final ImagePicker _picker = ImagePicker();
  late Planta _planta;

  Future<void> _cargarDatos() async {
    final plantas = await DBService.getPlantas();
    _planta = plantas.firstWhere((p) => p.id == widget.id);
    _nombreController.text = _planta.nombre;
    _descripcionController.text = _planta.descripcion;
    _imagen = _planta.imagen;
  }

  Future<void> _actualizarPlanta() async {
    if (_formKey.currentState!.validate()) {
      final actualizada = Planta(
        id: _planta.id,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        imagen: _imagen,
      );

      await DBService.updatePlanta(actualizada);
      if (context.mounted) context.pop();
    }
  }

  Future<void> _pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    print('Imagen seleccionada con ${bytes.length} bytes');
    setState(() {
      _imagen = bytes;
    });
  } 
}


  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Planta')),
      body: FutureBuilder(
        future: _cargarDatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  TextFormField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(labelText: 'Humedad y Temperatura'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  const SizedBox(height: 20),
                  const Text('Imagen de la Planta'),
                  const SizedBox(height: 8),
                  _imagen != null
                      ? Image.memory(_imagen!, height: 100)
                      : const Placeholder(fallbackHeight: 100),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Cambiar Imagen'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _actualizarPlanta,
                    child: const Text('Actualizar Planta'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
