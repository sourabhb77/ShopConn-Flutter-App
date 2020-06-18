import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/models/SavedProductData.dart';

class BookNotifier with ChangeNotifier {
  List<Book> _bookList = [];
  Book _currentBook;

  UnmodifiableListView<Book> get bookList => UnmodifiableListView(_bookList);

  Book get currentBook => _currentBook;

  set bookList(List<Book> bookList) {
    _bookList = bookList;
    notifyListeners();
  }

  // QuerySnapshot _newcurrentBook;
  set currentBook(Book book) {
    _currentBook = book;
    notifyListeners();
  }

  // addBook(Book book) {
  //   _bookList.insert(0, book);
  //   notifyListeners();
  // }

  // deleteBook(Book book) {
  //   _bookList.removeWhere((_book) => _book.id == book.id);
  //   notifyListeners();
  // }
}