import 'package:hola_mundo/models/planta_model.dart';
import 'package:path/path.dart'; 
import 'package:sqflite/sqflite.dart'; 


class DBService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('plantas.db'); // Inicializa si no existe
    return _database!;
  }

  /// Inicializa la base de datos en la ruta segura del sistema
  static Future<Database> _initDB(String fileName) async {
    final dbPath =
        await getDatabasesPath(); 
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        
        return db.execute('''
          CREATE TABLE plantas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            descripcion TEXT NOT NULL,
            imagen BLOB
          )
        ''');
      },
    );
  }

  /// Inserta una nueva categoría en la base de datos
  static Future<int> insertPlanta(Planta cat) async {
    final db = await database;
    return await db.insert('plantas', cat.toMap());
  }

  static Future<List<Planta>> getPlantas() async {
    final db = await database;
    final res = await db.query('plantas');
    return res.map((e) => Planta.fromMap(e)).toList();
  }

  /// Actualiza una categoría existente según su ID
  static Future<int> updatePlanta(Planta cat) async {
    final db = await database;
    return await db.update(
      'plantas',
      cat.toMap(),
      where: 'id = ?', 
      whereArgs: [cat.id], 
    );
  }

   /// Elimina una planta de la base de datos según su ID
  static Future<int> deletePlanta(int id) async {
    final db = await database;
    return await db.delete(
      'plantas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
