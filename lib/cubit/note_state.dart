import '../model/note_model.dart';

abstract class NoteState{}

class InitialState extends NoteState{}

class LoadingState extends NoteState{}

class LoadedState extends NoteState{
  List<NoteModel> mNotes;
  LoadedState({required this.mNotes});
}

class ErrorState extends NoteState{
  String errorMsg;
  ErrorState({required this.errorMsg});
}
