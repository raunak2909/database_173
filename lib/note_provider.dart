import 'package:database_173/model/note_model.dart';
import 'package:flutter/foundation.dart';

import 'app_db.dart';

class NoteProvider extends ChangeNotifier{
  AppDataBase db;
  NoteProvider({required this.db});

  List<NoteModel> _arrNotes = [];

  List<NoteModel> getNotes() => _arrNotes;

  ///events
  void getAllNotes() async{
    _arrNotes = await db.fetchNotes();
    notifyListeners();
  }

  void addNote(NoteModel newNote) async{
    await db.addNote(newNote);
    _arrNotes = await db.fetchNotes();
    notifyListeners();
  }

  ///update note

  ///delete note

}