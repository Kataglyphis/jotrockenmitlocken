import 'package:jotrockenmitlockenrepo/Media/DataTable/table_data.dart';

class Film extends TableData {
  String title = "placeholder";
  String isan = "placeholder";
  Film({required this.title, required this.isan});

  @override
  List<String> getCells() {
    return [title, isan];
  }

  @override
  List<double> getSpacing() {
    return [0.33, 0.33, 0.33];
  }
}
