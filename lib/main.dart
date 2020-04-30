import 'package:flutter/material.dart';
import 'package:flutter_api/views/note_list.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_api/models/note_services.dart';

void setupLocator()
{
  GetIt.I.registerLazySingleton(()=> NotesService());

}


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}

