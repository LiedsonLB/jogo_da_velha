import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    _database ??= await _initDB('game_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE game_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        winner TEXT,
        mode TEXT,
        boardState TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> saveGame(String winner, String mode, String boardState) async {
    final db = await instance.database;

    final isoDate = DateTime.now().toIso8601String();

    final data = {
      'winner': winner,
      'mode': mode,
      'boardState': boardState,
      'date': isoDate,
    };

    await db.insert('game_history', data);
    print(data);
    print('Jogo salvo com sucesso');
  }

  Future<List<Map<String, dynamic>>> fetchGameHistory() async {
    final db = await instance.database;
    return await db.query('game_history', orderBy: 'date DESC');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }
}
