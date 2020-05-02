import 'package:flutter/material.dart';
import 'package:flutter_api/models/note.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_api/models/note_services.dart';

class NoteModify extends StatefulWidget {
  final String noteId;
  NoteModify({this.noteId});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController=TextEditingController();
  TextEditingController _contentController=TextEditingController();

  bool _isLoading=false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading=true;
    });
    notesService.getNote(widget.noteId)
    .then((response){
      setState(() {
        _isLoading=false;
      });
      if(response.error==true)
        {
          errorMessage=response.errormessage ?? 'Something went wrong';
        }
      note=response.data;
      _titleController.text=note.noteTitle;
      _contentController.text=note.noteContent;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(isEditing? 'Edit note' : 'create note')),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child:_isLoading? Center(child: CircularProgressIndicator(),): Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration:InputDecoration(

                hintText: 'Note title'
              )
            ),
            Container(height:8),
            TextField(
              controller: _contentController,
              decoration:InputDecoration(
                hintText: 'Note content'
              ),

            ),
            Container(height:16),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child:Text('Submit',style: TextStyle(
                color: Colors.white,
                ),
                  ),
                color:Theme.of(context).primaryColor,
                onPressed: (){

                },
              ),

            ),

          ],
        ),
      ),
    );
  }
}
