import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';

class UserSettings {
  UserSettings(
      {required this.socialMediaLinksConfig,
      required this.businessEmail,
      required this.myQuotation,
      required this.firstName,
      required this.lastName,
      required this.assetPathImgOfMe}) {
    myName = "$firstName $lastName";
  }
  Map<String, ExternalLinkConfig>? socialMediaLinksConfig;
  String? businessEmail;
  String? myQuotation;
  String? firstName;
  String? lastName;
  String? myName;
  String? assetPathImgOfMe;

  ExternalLinkConfig getFullPathToGithubRepo(String repo) {
    ExternalLinkConfig github = socialMediaLinksConfig!["GitHub"]!;
    github.path += repo;
    return github;
  }
}
