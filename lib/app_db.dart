import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  //private constructor (Singleton)
  AppDataBase._();

  static final AppDataBase instance = AppDataBase._();

  Database? myDB;

  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(docDirectory.path, "noteDb.db");

    return await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
      //create all your tables here

      db.execute(
          "create table notes ( noteId integer primary key autoincrement, title text, desc text )");
    });
  }

  Future<Database> getDB() async{
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDB();
      return myDB!;
    }
  }


  void addNote(String mTitle, String mDesc) async{

    var db = await getDB();

    db.insert("notes", {
      "title" : mTitle,
      "desc" : mDesc
    });

  }

  Future<List<Map<String, dynamic>>> fetchNotes() async{

    var db = await getDB();

    var data = await db.query("notes");

    return data;
  }
}
