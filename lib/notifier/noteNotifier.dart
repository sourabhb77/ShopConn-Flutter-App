import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shopconn/models/note.dart';



class NoteNotifier with ChangeNotifier{
  List<Note> _noteList=[];
  Note _currentNote;


  UnmodifiableListView<Note> get noteList =>UnmodifiableListView(_noteList);
  Note get currentNote =>_currentNote;
 
  set noteList(List<Note> noteList ){
   _noteList=noteList;
   notifyListeners();
  }

  set currentNote(Note note)
  {
    _currentNote=note;
    notifyListeners();
  }

  addNote( Note note){
    _noteList.insert(0,note);
    notifyListeners();
  }
 
  deleteNote(Note note){
    _noteList.removeWhere((_note)=>_note.id==note.id);
    notifyListeners();
  }
}