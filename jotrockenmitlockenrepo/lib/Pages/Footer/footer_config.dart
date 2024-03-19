import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';

abstract class FooterConfig {
  String getLiabilityText(BuildContext context);
  String getExternalLinksTitle(BuildContext context);
  List<ExternalLinkConfig> getExternalLinks(BuildContext context);
}
