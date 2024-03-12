import 'package:jotrockenmitlockenrepo/Media/data.dart';

class Film extends Data {
  String title = "placeholder";
  String isan = "placeholder";
  Film({required this.title, required this.isan});

  @override
  List<String> getCells() {
    return [title, isan];
  }
}
