import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/note.dart';
import '../model/note.dart';


class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertNote(NoteBookModel note) async {
    Database db = await database;
    return await db.insert('notes', note.toJson());
  }

  Future<int> updateNoteById(NoteBookModel updatedNote) async {
    Database db = await database;
    return await db.update('notes', updatedNote.toJson(), where: 'id = ?', whereArgs: [updatedNote.id]);
  }


  Future<int> deleteNoteById(int id) async {
    Database db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NoteBookModel>> getNotes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (index) {
      return NoteBookModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        description: maps[index]['description'],
      );
    });
  }
}