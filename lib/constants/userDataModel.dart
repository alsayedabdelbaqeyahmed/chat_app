import 'package:chatapp/constants/constants.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDataModel {
  // static String? friendPhone;
  // static String? userPhone;
  String? userPhone2;
  String? username;
  String? friendPhone;
  int? id;
  UserDataModel({this.userPhone2, this.username, this.friendPhone, this.id});

  toJason() {
    return {
      AppConstansts.conuserName: username,
      AppConstansts.conuserPhone: userPhone2,
      AppConstansts.conFriendPhone: friendPhone,
      'id': id,
    };
  }

  UserDataModel.fromJason(Map<String, dynamic> map) {
    username = map[AppConstansts.conuserName];
    userPhone2 = map[AppConstansts.conuserPhone];
    friendPhone = map[AppConstansts.conFriendPhone];
    id = map['id'];
  }
}

class LocalDataBase {
  LocalDataBase._();

  static LocalDataBase db = LocalDataBase._();

  static Database? _database;

  Future<Database>? get dataBase async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'userPhoneNumber.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE ${AppConstansts.conUserCollectios} (id INTEGER PRIMARY KEY, ${AppConstansts.conuserName} TEXT, ${AppConstansts.conuserPhone} TEXT, ${AppConstansts.conFriendPhone} TEXT)');
      },
    );
  }

  Future<int> insertData(UserDataModel data) async {
    try {
      var _db = await dataBase;

      return await _db!.insert(AppConstansts.conUserCollectios, data.toJason());
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<int> updateData(UserDataModel user) async {
    var _db = await dataBase;
    return _db!.update(AppConstansts.conUserCollectios, user.toJason(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  // Future<int> updateele(UserDataModel user) async {
  //   var _db = await dataBase;
  //   return _db!.rawUpdate(sql);
  // }

  Future<UserDataModel> getUserData() async {
    var _db = await dataBase;
    try {
      List<Map<String, dynamic>> userMap =
          await _db!.query(AppConstansts.conUserCollectios);
      // print(userMap);
      List<UserDataModel> userData = [];
      userMap.isNotEmpty
          ? userData = userMap.map((e) => UserDataModel.fromJason(e)).toList()
          // ignore: unnecessary_statements
          : [];
      // print(userData.last);
      return userData.last;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<int> deleteAllData() async {
    var _db = await dataBase;
    try {
      return _db!.delete(AppConstansts.conUserCollectios);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
