import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';

class UserSettings {
  static final Map<String, ExternalLinkConfig> socialMediaLinksConfig = {
    'Facebook':
        ExternalLinkConfig(host: 'www.facebook.com', path: 'jonas.heinle/'),
    'GitHub': ExternalLinkConfig(host: 'www.github.com', path: 'Kataglyphis/'),
    'YouTube': ExternalLinkConfig(
        host: 'www.youtube.com', path: 'channel/UC3LZiH4sZzzaVBCUV8knYeg'),
    'X': ExternalLinkConfig(host: 'www.twitter.com', path: 'Cataglyphis_'),
    'LinkedIn': ExternalLinkConfig(
        host: 'www.linkedin.com', path: 'in/jonas-heinle-0b2a301a0/'),
    'Instagram': ExternalLinkConfig(
        host: 'www.instagram.com', path: 'jotrockenmitlocken'),
    'PayPal': ExternalLinkConfig(host: 'www.paypal.me', path: '/JonasHeinle'),
  };
  static const String businessEmail = "cataglyphis@jotrockenmitlocken.de";
  static const String myQuotation =
      "»As soon as it works, no-one calls it AI anymore.« (John McCarthy)";
  static const String firstName = "Jonas";
  static const String lastName = "Heinle";
  static const String myName = "$firstName $lastName";
  static const String assetPathImgOfMe =
      "assets/images/Bewerbungsbilder/a95a64ca.jpg";
  static appendRepoToGitHubUserLink(String repo) {
    ExternalLinkConfig github = socialMediaLinksConfig["GitHub"]!;
    github.path += repo;
    return github;
  }
}
