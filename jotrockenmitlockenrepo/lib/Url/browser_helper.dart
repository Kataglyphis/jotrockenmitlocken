import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

class BrowserHelper {
  static Future<void> launchInBrowser(ExternalLinkConfig link) async {
    final Uri url = Uri(scheme: 'https', host: link.host, path: link.path);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      developer.log('Could not launch $url');
    }
  }
}
