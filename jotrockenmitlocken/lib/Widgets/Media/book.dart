import 'package:jotrockenmitlockenrepo/Media/data.dart';

class Book extends Data {
  String title = "placeholder";
  String author = "placeholder";
  String ISBN = "placeholder";
  Book({required this.title, required this.author, required this.ISBN});

  @override
  List<String> getCells() {
    return [title, author, ISBN];
  }
}
