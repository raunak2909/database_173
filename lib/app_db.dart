import 'package:database_173/model/note_model.dart';
import 'package:database_173/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  //private constructor (Singleton)
  AppDataBase._();

  static final AppDataBase instance = AppDataBase._();

  Database? myDB;

  ///login pref key
  static final String LOGIN_UID = "uid";

  ///table
  static final String NOTE_TABLE = "notes";
  static final String USER_TABLE = "users";

  ///users columns
  static final String COLUMN_USER_ID = "uId";
  static final String COLUMN_USER_NAME = "uName";
  static final String COLUMN_USER_EMAIL = "uEmail";
  static final String COLUMN_USER_PASS = "uPass";

  ///note columns
  ///add uid here also
  static final String COLUMN_NOTE_ID = "noteId";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(docDirectory.path, "noteDb.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      //create all your tables here

      db.execute(
          "create table $USER_TABLE ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_PASS text)");

      db.execute(
          "create table $NOTE_TABLE ( $COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text )");
    });
  }

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDB();
      return myDB!;
    }
  }

  Future<bool> addNote(NoteModel newNote) async {
    var db = await getDB();
    var uid = await getUID();
    newNote.user_id = uid;

    var rowEffected = await db.insert(NOTE_TABLE, newNote.toMap());

    return rowEffected>0;
  }

  Future<int> getUID() async{
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getInt(AppDataBase.LOGIN_UID);
    return uid ?? 0;
  }

  Future<List<NoteModel>> fetchNotes() async {

    var uid = await getUID();

    var db = await getDB();
    List<NoteModel> arrNotes = [];

    var data = await db.query(NOTE_TABLE, where: "$COLUMN_USER_ID = ?", whereArgs: ['$uid']);

    for (Map<String, dynamic> eachMap in data) {
      var noteModel = NoteModel.fromMap(eachMap);
      arrNotes.add(noteModel);
    }

    return arrNotes;
  }

  void updateNote(NoteModel updatedNote) async {
    var db = await getDB();

    //db.update(NOTE_TABLE, updatedNote.toMap(), where: "$COLUMN_NOTE_ID = ${updatedNote.note_id}");
    db.update(NOTE_TABLE, updatedNote.toMap(),
        where: "$COLUMN_NOTE_ID = ?", whereArgs: ['${updatedNote.note_id}']);
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDB();

    var rowsEffected = await db.delete(NOTE_TABLE, where: "$COLUMN_NOTE_ID = $id");
    return rowsEffected>0;
  }

  ///Queries for USER
  Future<bool> createAccount(UserModel newUser) async{

    var check = await checkIfUserAlreadyExists(newUser.user_email);

    if(!check){
      // create user
      var db = await getDB();
      db.insert(USER_TABLE, newUser.toMap());
      return true;
    } else {
      // do not create account
      return false;
    }
  }

  Future<bool> checkIfUserAlreadyExists(String email) async{
    var db = await getDB();

    var data = await db.query(USER_TABLE, where: "$COLUMN_USER_EMAIL = ?", whereArgs: [email]);

    return data.isNotEmpty;
  }

  ///login
  Future<bool> authenticateUser(String email, String pass) async{
    var db = await getDB();

    var data = await db.query(USER_TABLE, where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?", whereArgs: [email, pass]);

    if(data.isNotEmpty){
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt(LOGIN_UID, UserModel.fromMap(data[0]).user_id);
    }

    return data.isNotEmpty;
  }




}
