import 'package:jotrockenmitlocken/Media/data.dart';

class Film extends Data {
  String title = "placeholder";
  String ISAN = "placeholder";
  Film(final String title, String ISAN) {
    this.title = title;
    this.ISAN = ISAN;
  }
  @override
  List<String> getCells() {
    return [title, ISAN];
  }
}
