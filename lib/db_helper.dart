import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'nota.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _abrirBD();
    return _db!;
  }

  Future<Database> _abrirBD() async {
    final ruta = join(await getDatabasesPath(), 'notas.db');
    return openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            contenido TEXT
          )
        ''');
      },
    );
  }

  // CREATE
  Future<int> insertarNota(Nota nota) async {
    final db = await database;
    return db.insert('notas', nota.toMap()..remove('id'));
  }

  // READ
  Future<List<Nota>> obtenerNotas() async {
    final db = await database;
    final filas = await db.query('notas', orderBy: 'id DESC');
    return filas.map((f) => Nota.fromMap(f)).toList();
  }

  // UPDATE
  Future<int> actualizarNota(Nota nota) async {
    final db = await database;
    return db.update('notas', nota.toMap(),
        where: 'id = ?', whereArgs: [nota.id]);
  }

  // DELETE
  Future<int> eliminarNota(int id) async {
    final db = await database;
    return db.delete('notas', where: 'id = ?', whereArgs: [id]);
  }
}