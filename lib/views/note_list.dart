import 'package:flutter/material.dart';
import 'package:flutter_api/models/api_response.dart';
import 'package:flutter_api/models/note_services.dart';
import 'package:flutter_api/views/create_note.dart';
import 'package:flutter_api/views/note_delete.dart';
import 'package:flutter_api/views/noteforlist.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  ApiResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading=false;

  String formatDateTime(DateTime dateTime)
  {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  @override
  void initState() {
    _fetchNotes();

    super.initState();
  }
  _fetchNotes() async{
    setState(() {
      _isLoading=true;
    });
    _apiResponse=await service.getNotesList();

    setState(() {
      _isLoading=false;
    });
  }
//_isLoading ? CircularProgressIndicator() :


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('List of notes')),
      floatingActionButton: FloatingActionButton
        (
        onPressed: ()
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteModify()))
          .then((_){
            _fetchNotes();
          });
        },
        child: Icon(Icons.add),
      ),
      body:Builder(
        builder: (_)
        {
          if(_isLoading)
            {
              return (Center(child:CircularProgressIndicator() ,));
            }
          if(_apiResponse.error ==true)
            {
              //
              return Center(child: Text(_apiResponse.errormessage));
            }
          return ListView.separated(
            separatorBuilder:(_,__) =>Divider(height: 1,color: Colors.black,),
            itemBuilder: (_,index){
              return Dismissible(
                key:ValueKey(_apiResponse.data[index].noteId),
                direction:DismissDirection.startToEnd,
                onDismissed: (direction)
                {


                },
                confirmDismiss: (direction) async
                {
                  final result=await showDialog(context: context,
                      builder: (_) => notedelete()
                  );
                  return result;

                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(child: Icon(Icons.delete,color: Colors.white,),alignment: Alignment.centerLeft,),
                ),
                child: ListTile(
                    title: Text(
                      _apiResponse.data[index].noteTitle ,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: Text('Last edited on ${formatDateTime(_apiResponse.data[index].lastEditDateTime ?? _apiResponse.data[index].createDateTime                    )}'),
                    onTap:()
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder:(_)=>NoteModify(noteId:_apiResponse.data[index].noteId))).then((data){
                        _fetchNotes();
                      });
                    }
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      )



    );
  }
}
