import 'package:jotrockenmitlockenrepo/Media/DataTable/table_data.dart';

class Book extends TableData {
  String title = "placeholder";
  String author = "placeholder";
  String isbn = "placeholder";
  Book({required this.title, required this.author, required this.isbn});

  @override
  List<String> getCells() {
    return [title, author, isbn];
  }

  @override
  List<double> getSpacing() {
    return [0.25, 0.25, 0.25, 0.25];
  }
}
