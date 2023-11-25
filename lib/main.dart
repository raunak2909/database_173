import 'package:database_173/app_db.dart';
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
List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    appDB = AppDataBase.instance;
    getAllNotes();
  }

  void getAllNotes() async{
    data = await appDB.fetchNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: data.length,
          itemBuilder: (_, index){
          return ListTile(
            title: Text('${data[index]['title']}'),
            subtitle: Text('${data[index]['desc']}'),
          );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          appDB.addNote("New Note", "Implement DB in flutter app");
          getAllNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
