import 'package:jotrockenmitlocken/my_two_cents_config.dart';

String resolveMediaCommentRoute(
  List<MyTwoCentsConfig> configs,
  String mediaTitle,
) {
  final idx = configs.indexWhere((c) => c.mediaTitle == mediaTitle);
  return idx != -1 ? configs[idx].routingName : "";
}
