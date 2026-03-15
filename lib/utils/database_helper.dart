import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('moviesbox.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE downloads (
  _id $idType,
  movie_id $integerType,
  title $textType,
  overview $textType,
  poster_path $textType,
  backdrop_path $textType,
  vote_average $realType,
  release_date $textType,
  local_path $textType
)
''');
  }

  Future<void> insertDownload(Movie movie, String localPath) async {
    final db = await instance.database;
    await db.insert('downloads', {
      'movie_id': movie.id,
      'title': movie.title,
      'overview': movie.overview,
      'poster_path': movie.posterPath,
      'backdrop_path': movie.backdropPath,
      'vote_average': movie.voteAverage,
      'release_date': movie.releaseDate,
      'local_path': localPath,
    });
  }

  Future<List<Map<String, dynamic>>> getDownloads() async {
    final db = await instance.database;
    return await db.query('downloads');
  }

  Future<int> deleteDownload(int id) async {
    final db = await instance.database;
    return await db.delete(
      'downloads',
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isDownloaded(int movieId) async {
    final db = await instance.database;
    final maps = await db.query(
      'downloads',
      columns: ['_id'],
      where: 'movie_id = ?',
      whereArgs: [movieId],
    );
    return maps.isNotEmpty;
  }
}
