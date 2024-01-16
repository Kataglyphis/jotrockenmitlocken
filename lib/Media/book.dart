import 'package:jotrockenmitlocken/Media/data.dart';

class Book extends Data {
  String title = "placeholder";
  String author = "placeholder";
  String ISBN = "placeholder";
  Book(final String title, String author, String ISBN) {
    this.title = title;
    this.author = author;
    this.ISBN = ISBN;
  }

  @override
  List<String> getCells() {
    return [title, author, ISBN];
  }
}
