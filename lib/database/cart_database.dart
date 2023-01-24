import 'package:food_app/models/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._initialize();
  static Database? _database;
  CartDatabase._initialize();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDb('cart.db');
      return _database;
    }
  }

  Future<Database> _initDb(String fileName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      //onConfigure: _onconfigure,
    );
  }

  Future _createDB(Database db, int version) async {
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN';
    final intType = 'INTEGER NOT NULL';

    await db.execute(''' CREATE TABLE $cartTable (
${CartFields.id} $intType,
${CartFields.img} $textType,
${CartFields.isExit} $boolType,
${CartFields.name} $textType,
${CartFields.price} $intType,
${CartFields.quantity} $intType,
${CartFields.time} $textType
)
''');
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  //CRUD operations for cart
//create or insert a todo
  Future<CartModel> addToCart(CartModel cart) async {
    final db = await instance.database;
  await db!.insert(cartTable, cart.toJson());
    return cart;
  }

  //Reading All todos
  Future<List<CartModel>> getAllCart() async {
    final db = await instance.database;
    final result = await db!.query(
      cartTable,
      orderBy:
          // You can also order by title
          '${CartFields.time} DESC',

      // where: ' ${TodoFields.username} = ?',
      //whereArgs: [username],
    );
    return result.map((e) => CartModel.fromJson(e)).toList();
  }

   //Deleting a todo
  Future<void> deleteCart() async {
    final db = await instance.database;
    await db!.delete(
      cartTable,
      // where: '${TodoFields.title} = ? AND ${TodoFields.username} = ?',
      // whereArgs: [todo.title, todo.username],
    );
  }
}
