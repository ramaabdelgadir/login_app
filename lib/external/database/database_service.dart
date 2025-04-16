import 'package:login_app/stores/model/store_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {

  static Database? _db;
  static final DatabaseService  instance = DatabaseService._constructor();

  final String _storesTableName = "stores";
  final String _storesIdColumnName = "id";
  final String _storesNameColumnName = "name";
  final String _storesReviewColumnName = "review";
  final String _storesLocationColumnName = "location";




  DatabaseService._constructor();

  Future<Database> get database async{
      if (_db != null) return _db!;
      _db = await getDatabase();
      return _db!;

  }


  Future<Database> getDatabase() async{
    final databaseDirpath = await getDatabasesPath();
    final databasePath = join(databaseDirpath,"stores_db.db");
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE ${_storesTableName} (
        $_storesIdColumnName INTEGER PRIMARY KEY,
        $_storesNameColumnName TEXT NOT NULL,
        $_storesLocationColumnName TEXT NOT NULL,
        $_storesReviewColumnName REAL NOT NULL

        )  
          
          ''');
      },

    );
    return database;
  }


  void addStore(StoreModel store) async{
    final storeMap = store.toMap();
    final db = await database;
    await db.insert(_storesTableName, {
      _storesNameColumnName: storeMap['name'],
      _storesLocationColumnName: storeMap['location'],
      _storesReviewColumnName: storeMap['review']
    });
  }



  Future<List<StoreModel>> getStores() async{

  final db = await database;
  final data = await db.query(_storesTableName);
  
  List<StoreModel> stores = data.map((e)=> StoreModel.fromMap(e)).toList();
  return stores;
  }

  void deleteStore(int id) async{
    final db = await database;
    await db.delete(
      _storesTableName,
      where: 'id = ?',
      whereArgs: [
        id,
      ]
    );
  }
}