import 'package:database_173/app_db.dart';

class NoteModel {
  int note_id;
  String note_title;
  String note_desc;

  NoteModel({
      required this.note_id,
      required this.note_title,
      required this.note_desc
      });

  //fromMap --> Model
  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
        note_id: map[AppDataBase.COLUMN_NOTE_ID],
        note_title: map[AppDataBase.COLUMN_NOTE_TITLE],
        note_desc: map[AppDataBase.COLUMN_NOTE_DESC]);
  }


  // Model --> toMap
  Map<String, dynamic> toMap(){
    return {
      AppDataBase.COLUMN_NOTE_TITLE : note_title,
      AppDataBase.COLUMN_NOTE_DESC : note_desc
    };
  }

}
