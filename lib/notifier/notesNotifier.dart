import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shopconn/models/notes.dart';



class NotesNotifier with ChangeNotifier{
  List<Notes> _notesList=[];
  Notes _currentNotes;


  UnmodifiableListView<Notes> get notesList =>UnmodifiableListView(_notesList);
  Notes get currentNotes =>_currentNotes;
 
  set notesList(List<Notes> notesList ){
   _notesList=notesList;
   notifyListeners();
  }

  set currentNotes(Notes notes)
  {
    _currentNotes=notes;
    notifyListeners();
  }

  addNotes( Notes notes){
    _notesList.insert(0,notes);
    notifyListeners();
  }
 
  deleteNotes(Notes notes){
    _notesList.removeWhere((_notes)=>_notes.id==notes.id);
    notifyListeners();
  }
}