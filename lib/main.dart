import 'dart:io';

import 'package:database_173/add_note_page.dart';
import 'package:database_173/app_db.dart';
import 'package:database_173/cubit/note_cubit.dart';
import 'package:database_173/cubit/note_state.dart';
import 'package:database_173/model/note_model.dart';
import 'package:database_173/note_provider.dart';
import 'package:database_173/user_onboarding/login_page.dart';
import 'package:database_173/user_onboarding/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(BlocProvider<NoteCubit>(
    create: (context) => NoteCubit(appDb: AppDataBase.instance),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*late AppDataBase appDB;
  int? uid = 0;
  List<NoteModel> data = [];*/
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ///to get all notes when app opens


    /*appDB = AppDataBase.instance;
    getUID();*/
  }

  /*void getUID() async {
    var prefs = await SharedPreferences.getInstance();
    uid = prefs.getInt(AppDataBase.LOGIN_UID);
    getAllNotes();
  }*/

  /*void getAllNotes() async {
    data = await appDB.fetchNotes(uid!);
    data = data.reversed.toList();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    context.read<NoteCubit>().getAllNotes();
    print("build called!!");
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (_, state){
          if(state is LoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is ErrorState){
            return Center(child: Text('${state.errorMsg}'),);
          }

          if(state is LoadedState){
            return state.mNotes.isNotEmpty
                ? ListView.builder(
                itemCount: state.mNotes.length,
                itemBuilder: (_, index) {
                  var currData = state.mNotes[index];

                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(currData.note_title),
                    subtitle: Text(currData.note_desc),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                ///update the data
                                /*callMyBottomSheet(
                                  isUpdate: true,
                                  uId: currData.user_id,
                                  noteId: currData.note_id,
                                  title: currData.note_title,
                                  desc: currData.note_desc);*/
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          InkWell(
                              onTap: () {
                                ///delete the data
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text("Delete?"),
                                        content: Text(
                                            "Are you sure want to delete this Note?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                /// delete operation here..
                                                context.read<NoteCubit>().deleteNote(currData.note_id);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No')),
                                        ],
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  );
                })
                : Container();
          }
          
          return Container();
        },
      )

      /*Consumer<NoteProvider>(
        builder: (ctx, provider, child){
          var notes = provider.getNotes();
          return notes.isNotEmpty
              ? ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, index) {
                var currData = notes[index];

                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(currData.note_title),
                  subtitle: Text(currData.note_desc),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              ///update the data
                              *//*callMyBottomSheet(
                                  isUpdate: true,
                                  uId: currData.user_id,
                                  noteId: currData.note_id,
                                  title: currData.note_title,
                                  desc: currData.note_desc);*//*
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        InkWell(
                            onTap: () {
                              ///delete the data
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delete?"),
                                      content: Text(
                                          "Are you sure want to delete this Note?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              /// delete operation here..
                                              *//*appDB
                                                  .deleteNote(currData.note_id);*//*
                                              Navigator.pop(context);
                                            },
                                            child: Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No')),
                                      ],
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                );
              })
              : Container();
        },
      ),*/,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //callMyBottomSheet();
          //for adding note

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotePage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  /*void callMyBottomSheet(
      {bool isUpdate = false,
      int uId = 0,
      int noteId = 0,
      String title = "",
      String desc = ""}) {
    titleController.text = title;
    descController.text = desc;
    *//*else {
      titleController.text = "";
      descController.text = "";
    }*//*

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 550,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(isUpdate ? 'Update Note' : 'Add Note'),
                TextField(
                  controller: titleController,
                ),
                TextField(
                  controller: descController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              descController.text.isNotEmpty) {
                            if (isUpdate) {
                              ///update note here
                              appDB.updateNote(NoteModel(
                                  user_id: uId,
                                  note_id: noteId,
                                  note_title: titleController.text.toString(),
                                  note_desc: descController.text.toString()));
                            } else {
                              ///add note here
                              appDB.addNote(NoteModel(
                                  user_id: uid!,
                                  note_id: 0,
                                  note_title: titleController.text.toString(),
                                  note_desc: descController.text.toString()));
                            }
                            getAllNotes();

                            Navigator.pop(context);
                          }
                        },
                        child: Text(isUpdate ? 'Update' : 'Add')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'))
                  ],
                )
              ],
            ),
          );
        });
  }*/
}
