import 'dart:io';

import 'package:database_173/app_db.dart';
import 'package:database_173/model/note_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDataBase appDB;
  List<NoteModel> data = [];

  @override
  void initState() {
    super.initState();
    appDB = AppDataBase.instance;
    getAllNotes();
  }

  void getAllNotes() async {
    data = await appDB.fetchNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: data.isNotEmpty ? ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, index) {

            var currData = data[index];

            return ListTile(
              leading: Text('${currData.note_id}'),
              title: Text(currData.note_title),
              subtitle: Text(currData.note_desc),
            );
          }) : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appDB.addNote(NoteModel(
              note_id: 0,
              note_title: "New Note",
              note_desc: "Implement DB in flutter app"));
          getAllNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
