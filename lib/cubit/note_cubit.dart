import 'package:database_173/app_db.dart';
import 'package:database_173/model/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  AppDataBase appDb;

  NoteCubit({required this.appDb}) : super(InitialState());

  ///events
  ///addNote

  void addNote(NoteModel newNote) async {
    emit(LoadingState());
    var check = await appDb.addNote(newNote);
    if (check) {
      List<NoteModel> arrNotes = await appDb.fetchNotes();
      emit(LoadedState(mNotes: arrNotes));
    } else {
      emit(ErrorState(errorMsg: "Note not Added!!"));
    }
  }

  void getAllNotes() async {
    emit(LoadingState());
    List<NoteModel> arrNotes = await appDb.fetchNotes();
    emit(LoadedState(mNotes: arrNotes));
  }

  void deleteNote(int id) async{
    emit(LoadingState());
    var check = await appDb.deleteNote(id);
    if(check){
      List<NoteModel> arrNotes = await appDb.fetchNotes();
      emit(LoadedState(mNotes: arrNotes));
    } else {
      emit(ErrorState(errorMsg: "Note not Deleted!!"));
    }
  }
}
