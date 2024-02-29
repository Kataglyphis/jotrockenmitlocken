import 'package:jotrockenmitlockenrepo/Media/data.dart';

class Film extends Data {
  String title = "placeholder";
  String ISAN = "placeholder";
  Film({required this.title, required this.ISAN});

  @override
  List<String> getCells() {
    return [title, ISAN];
  }
}
