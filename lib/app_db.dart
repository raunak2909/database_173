import 'package:database_173/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  //private constructor (Singleton)
  AppDataBase._();

  static final AppDataBase instance = AppDataBase._();

  Database? myDB;

  ///table
  static final String NOTE_TABLE = "notes";
  ///columns
  static final String COLUMN_NOTE_ID = "noteId";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";






  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(docDirectory.path, "noteDb.db");

    return await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
      //create all your tables here

      db.execute(
          "create table $NOTE_TABLE ( $COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text )");
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


  void addNote(NoteModel newNote) async{

    var db = await getDB();

    db.insert(NOTE_TABLE, newNote.toMap());

  }

  Future<List<NoteModel>> fetchNotes() async{

    var db = await getDB();
    List<NoteModel> arrNotes = [];

    var data = await db.query(NOTE_TABLE);

    for(Map<String, dynamic> eachMap in data){
      var noteModel = NoteModel.fromMap(eachMap);
      arrNotes.add(noteModel);
    }

    return arrNotes;
  }

  /*void deleteNote() async{
    var db = await getDB();

    db.delete(NOTE_TABLE, where:  "");
  }*/
}
