import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final DatabaseHelper instance=DatabaseHelper._();
  DatabaseHelper._();

  Database? _db;

  Future<Database> get database async{
    if(_db!=null) return _db!;
    _db=await _init();
    return _db!;
  }

  Future<Database> _init() async{
    final path=join(await getDatabasesPath(),'mywork.db');
    return openDatabase(path,version:1,onCreate:(db,v) async{
      await db.execute('''
      CREATE TABLE atendimentos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT,
        imagePath TEXT,
        status TEXT,
        createdAt TEXT
      )
      ''');
    });
  }
}
