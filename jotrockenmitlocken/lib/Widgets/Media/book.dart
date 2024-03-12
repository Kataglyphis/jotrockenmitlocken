import 'package:jotrockenmitlockenrepo/Media/data.dart';

class Book extends Data {
  String title = "placeholder";
  String author = "placeholder";
  String isbn = "placeholder";
  Book({required this.title, required this.author, required this.isbn});

  @override
  List<String> getCells() {
    return [title, author, isbn];
  }
}
