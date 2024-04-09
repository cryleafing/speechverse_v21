import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Flashcard {
  final int? id;
  final String frontText;
  final String backText;
  final int deckId;

  Flashcard({
    this.id,
    required this.frontText,
    required this.backText,
    required this.deckId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'front_text': frontText,
      'back_text': backText,
      'deck_id': deckId,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'],
      frontText: map['front_text'],
      backText: map['back_text'],
      deckId: map['deck_id'],
    );
  }
}

class FlashcardDatabaseHelper {
  static final FlashcardDatabaseHelper instance =
      FlashcardDatabaseHelper._init();
  static Database? _database;

  FlashcardDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('flashcards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE decks (
      id $idType,
      deck_name $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE flashcards (
      id $idType,
      front_text $textType,
      back_text $textType,
      deck_id INTEGER,
      FOREIGN KEY (deck_id) REFERENCES decks(id)
    )
    ''');
  }

  Future<int> addDeck(String deckName) async {
    final db = await instance.database;

    final id = await db.insert('decks', {'deck_name': deckName});
    return id;
  }

  Future<int> addFlashcard(
      {required String frontText,
      required String backText,
      required int deckId}) async {
    final db = await instance.database;

    final id = await db.insert('flashcards', {
      'front_text': frontText,
      'back_text': backText,
      'deck_id': deckId,
    });
    return id;
  }

  Future<List<Map<String, dynamic>>> getAllDecks() async {
    final db = await instance.database;

    final result = await db.query('decks');
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> getFlashcards(int deckId) async {
    final db = await instance.database;

    final result = await db.query(
      'flashcards',
      where: 'deck_id = ?',
      whereArgs: [deckId],
    );
    return result.toList();
  }

  // Implement other CRUD methods as needed

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrade if needed
  }

  Future<List<Flashcard>> getFlashcardsForDeck(int? deckId) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'flashcards',
      where: 'deck_id = ?',
      whereArgs: [deckId],
    );

    return List.generate(maps.length, (i) {
      return Flashcard(
        id: maps[i]['id'],
        frontText: maps[i]['front_text'],
        backText: maps[i]['back_text'],
        deckId: maps[i]['deck_id'],
      );
    });
  }
}
