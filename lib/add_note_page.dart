import 'package:database_173/app_db.dart';
import 'package:database_173/cubit/note_cubit.dart';
import 'package:database_173/note_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/note_model.dart';

class AddNotePage extends StatelessWidget {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print("build called!!");

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add Note'),
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
                      ///add note here
                      context.read<NoteCubit>().addNote(NoteModel(
                          user_id: 0,
                          note_id: 0,
                          note_title: titleController.text.toString(),
                          note_desc: descController.text.toString()));

                      Navigator.pop(context);

                      /*AppDataBase.instance.addNote(NoteModel(
                          user_id: uid!,
                          note_id: 0,
                          note_title: titleController.text.toString(),
                          note_desc: descController.text.toString()));

                      getAllNotes();*/


                    }
                  },
                  child: Text('Add')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          ),
        ],
      ),
    );
  }
}
