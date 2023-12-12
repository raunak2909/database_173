import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:database_173/model/note_model.dart';
import 'package:meta/meta.dart';

import '../app_db.dart';

part 'notedb_event.dart';
part 'notedb_state.dart';

class NotedbBloc extends Bloc<NotedbEvent, NotedbState> {
  AppDataBase db;
  NotedbBloc({required this.db}) : super(NotedbInitial()) {
    ///add note
    on<AddNoteEvent>((event, emit) async{
      emit(NotedbLoading());
      var check = await db.addNote(event.newNote);
      if(check){
        var listNotes = await db.fetchNotes();
        emit(NotedbLoaded(allNotes: listNotes));
      } else {
        emit(NotedbError(errorMsg: "Note not added!!"));
      }
    });

    ///fetch Note
    on<FetchAllNotes>((event, emit) async{
      emit(NotedbLoading());
      var listNotes = await db.fetchNotes();
      emit(NotedbLoaded(allNotes: listNotes));
    });
  }
}
