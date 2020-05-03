import 'dart:convert';
import 'dart:io';
import 'note.dart';
import 'api_response.dart';
import 'package:flutter_api/views/noteforlist.dart';
import  'package:http/http.dart' as http;
import 'note_insert.dart';

class NotesService
{
  static const API='http://api.notes.programmingaddict.com';
  static const headers={'apiKey':'14b8f4d3-9e05-4121-9e62-1c4c89503afa',
    'Content-Type':'application/json'};



  Future <ApiResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {

          notes.add(NoteForListing.fromJson(item));
        }
        return ApiResponse<List<NoteForListing>>(data: notes);
      }
      return ApiResponse<List<NoteForListing>>(
          error: true, errormessage: 'something went wrong');
    }


    ).catchError((_) =>
        ApiResponse<List<NoteForListing>>(
            error: true, errormessage: 'something went wrong'));
  }
  

  Future <ApiResponse<Note>> getNote(String noteId) {
    return http.get(API + '/notes/'+noteId, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
     
        return ApiResponse<Note>(data: Note.fromJson(jsonData));
      }
      return ApiResponse<Note>(
          error: true, errormessage: 'something went wrong');
    }


    ).catchError((_) =>
        ApiResponse<List<Note>>(
            error: true, errormessage: 'something went wrong'));
  }

  Future <ApiResponse<bool>> createnote(NoteInsert item) {
    return http.post(API + '/notes', headers: headers,body:json.encode(item.toJson()) ).then((data) {
      if (data.statusCode == 201) {

        return  ApiResponse<bool>(data: true);
      }
      return ApiResponse<bool>(
          error: true, errormessage: 'something went wrong');
    }


    ).catchError((_) =>
        ApiResponse<bool>(
            error: true, errormessage: 'something went wrong'));
  }




}