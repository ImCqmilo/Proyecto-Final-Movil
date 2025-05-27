import 'dart:typed_data';

class Planta {
  int? id;
  String nombre;
  String descripcion;
  Uint8List? imagen; 

  Planta({
    this.id,
    required this.nombre,
    required this.descripcion,
    this.imagen,
  });

  factory Planta.fromMap(Map<String, dynamic> json) => Planta(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        imagen: json['imagen'], 
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'imagen': imagen,
      };
}