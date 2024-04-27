import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class privateDB {
  Database? _database;

  String table_cetegory = "category";
  String id = "id";
  String name = "name";
  String price = "price";

  Future<Database?> get db async {
    if (_database == null) {
      _database = await initialDB();
      return _database;
    }
    return _database;
  }

  initialDB() async {
    String path = join(await getDatabasesPath(), "privateDB.db");
    Database DataBase = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return DataBase;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(''' create table  $table_cetegory (
        $id INTEGER PRIMARY KEY AUTOINCREMENT ,
        $name text not null ,
        $price integer not null
      )
    ''');

    await batch.commit();
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("drop table $table_cetegory");
    _onCreate(db, newVersion);
  }

  // method to insert data to db
  Future<int> insertData(String n, int p) async {
    Database? tempDb = await db;
    int response = await tempDb!.rawInsert(
        "INSERT INTO $table_cetegory(name, price) VALUES (?, ?)", [n, p]);
    return response;
  }

  // method to update data in db
  Future<int> updateData(int id, String n, int p) async {
    Database? tempDb = await db;
    int response = await tempDb!.update(
      table_cetegory,
      {'name': n, 'price': p},
      where: 'id = ?',
      whereArgs: [id],
    );
    return response;
  }

  // method to read data from database
  Future<List<Map<String, dynamic>>> readData() async {
    Database? tempDb = await db;
    List<Map<String, dynamic>> result = await tempDb!.query(table_cetegory);
    return result;
  }

  // method to read specific data 
  Future<Map<String, dynamic>> getData(int itemId) async {
  Database? tempDb = await db;
  List<Map<String, dynamic>> result = await tempDb!.query(
    table_cetegory,
    where: 'id = ?',
    whereArgs: [itemId],
  );

  if (result.isNotEmpty) {
    return result.first;
  } else {
    // Handle the case where the item with the specified ID is not found
    throw Exception('Item not found');
  }
}

  // method to delete item from database
  Future<int> deleteData(int id) async {
    Database? tempDb = await db;
    int response = await tempDb!.delete(
      table_cetegory,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response;
  }
}
