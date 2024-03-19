import 'package:jotrockenmitlockenrepo/Media/DataTable/table_data.dart';

class Quote extends TableData {
  String author = "placeholder";
  String content = "placeholder";
  Quote({required this.author, required this.content});

  @override
  List<String> getCells() {
    return [author, content];
  }

  @override
  List<double> getSpacing() {
    return [0.2, 0.65];
  }
}
