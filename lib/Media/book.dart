import 'package:flutter/cupertino.dart';

class Book {
  String title = "placeholder";
  String author = "placeholder";
  String genre = "placeholder";
  String read = "placeholder";
  String year = "placeholder";
  Book(final String title, String author, String genre, String read,
      String year) {
    this.title = title;
    this.author = author;
    this.genre = genre;
    this.read = read;
    this.year = year;
  }
}
