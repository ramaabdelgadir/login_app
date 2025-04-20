import 'package:login_app/stores/model/store_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {

  static Database? _db;
  static final DatabaseService  instance = DatabaseService._constructor();

  final String _storesTableName = "stores";
  final String _storesIdColumnName = "store_id";
  final String _storesNameColumnName = "store_name";
  final String _storesReviewColumnName = "store_review";
  final String _storesImageColumnName = "store_image";
  final String _store_location_longitudeColumnName ="store_location_longitude";
  final String _store_location_latitudeColumnName ="store_location_latitude";
  




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
        $_storesIdColumnName INTEGER NOT NULL,
        $_storesNameColumnName TEXT NOT NULL,
        $_storesImageColumnName TEXT NOT NULL,
        $_storesReviewColumnName REAL NOT NULL,
        $_store_location_longitudeColumnName REAL NOT NULL,
        $_store_location_latitudeColumnName REAL NOT NULL

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
      _storesIdColumnName:storeMap['store_id'],
      _storesNameColumnName: storeMap['store_name'],
      _store_location_latitudeColumnName: storeMap['store_location_latitude'],
      _store_location_longitudeColumnName: storeMap['store_location_longitude'],
      _storesImageColumnName:storeMap['store_image'],
      _storesReviewColumnName: storeMap['store_review']
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