part of 'notedb_bloc.dart';

@immutable
abstract class NotedbEvent {}

class AddNoteEvent extends NotedbEvent{
  NoteModel newNote;
  AddNoteEvent({required this.newNote});
}

class FetchAllNotes extends NotedbEvent{}