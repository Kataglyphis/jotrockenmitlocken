import 'package:jotrockenmitlockenrepo/Media/DataTable/data.dart';

class Quote extends Data {
  String author = "placeholder";
  String content = "placeholder";
  Quote({required this.author, required this.content});

  @override
  List<String> getCells() {
    return [author, content];
  }
}
