import 'package:jotrockenmitlocken/Media/data.dart';

class Quote extends Data {
  String author = "placeholder";
  String content = "placeholder";
  Quote(final String author, final String content) {
    this.author = author;
    this.content = content;
  }
  @override
  List<String> getCells() {
    return [author, content];
  }
}
