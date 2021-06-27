import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Model/basket.dart';
import 'Model/product.dart';
import 'Model/user.dart';

class DBHelper{

  String tableUser = 'user';
  String tableProduct = 'product';
  String tableBasket = 'basket';

  String DatabaesName = 'shoppingOnlineD.db';
  String sqlStatmentUser = 'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, firstName TEXT, lastName TEXT, email TEXT, password TEXT)';
  String sqlStatmentProduct = 'CREATE TABLE product (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, category TEXT, name TEXT, description TEXT, unitPrice DOUBLE, unit TEXT, image TEXT)';
  String sqlStatmentBasket = 'CREATE TABLE basket (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, unit TEXT, unitPrice DOUBLE, quantity INTEGER, image TEXT)';

  static DBHelper _helper;
  DBHelper._getInstance();

  factory DBHelper (){
    if(_helper == null)
      _helper = DBHelper._getInstance();
    return _helper;
  }
  static Database _dbb;
  Future<Database> initializedDB() async {

    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), DatabaesName);

    _dbb = await openDatabase(
        path,
        onCreate: (db, version)async{
          await db.execute(sqlStatmentUser);
          await db.execute(sqlStatmentProduct);
          await db.execute(sqlStatmentBasket);
        }
            ,
        version:1
    );
    return _dbb;
  }

  addNewUser(User user) async{
    if(_dbb == null) await initializedDB();
    _dbb.insert(tableUser, user.userRecord());
  }

  Future <List<Map<String, dynamic>>> checkEmailAndPassword(String email, String password )async{
    if(_dbb == null) await initializedDB();
    return _dbb.query(tableUser,where: 'email = ? and password = ?',whereArgs: [email, password]);
  }

  Future <List<Map<String, dynamic>>> checkEmail(String email)async{
    if(_dbb == null) await initializedDB();
    return _dbb.query(tableUser,where: 'email = ?',whereArgs: [email]);
  }

  addNewProduct(Product product) async{
    if(_dbb == null) await initializedDB();
    _dbb.insert(tableProduct, product.productRecord());
  }

  Future <List<Map<String, dynamic>>> geByIdProduct(int pId) async{
    if(_dbb == null)await initializedDB();
    return _dbb.query(tableProduct, where: 'id= $pId');
  }

  Future <List<Map<String, dynamic>>> getAllProduct(String category) async{
    if(_dbb == null)await initializedDB();
    return _dbb.query(tableProduct, where: 'category= ?' , whereArgs: [category]);
  }
  Future <List<Map<String, dynamic>>> checkTableProduct() async{
    if(_dbb == null)await initializedDB();
    return _dbb.query(tableProduct);
  }

    deleteProduct(int pid){
      _dbb.delete(tableProduct, where: 'id = ?',whereArgs: [pid]);
  }

  addOrder(Basket order) async{
    if(_dbb == null) await initializedDB();
    _dbb.insert(tableBasket, order.OrderRecord());
  }

  Future <List<Map<String, dynamic>>> getAllOrder() async{
    if(_dbb == null)await initializedDB();
    return _dbb.query(tableBasket);
  }

   deleteOrder(int oId)async{
   await _dbb.delete(tableBasket, where: 'id = ?',whereArgs: [oId]);
  }

}
