part of 'notedb_bloc.dart';

@immutable
abstract class NotedbState {}

class NotedbInitial extends NotedbState {}
class NotedbLoading extends NotedbState {}
class NotedbLoaded extends NotedbState {
  List<NoteModel> allNotes;
  NotedbLoaded({required this.allNotes});
}
class NotedbError extends NotedbState {
  String errorMsg;
  NotedbError({required this.errorMsg});
}
