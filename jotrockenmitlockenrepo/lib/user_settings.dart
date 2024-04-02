import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';

class UserSettings {
  UserSettings(
      {required this.socialMediaLinksConfig,
      required this.businessEmail,
      required this.myQuotation,
      required this.firstName,
      required this.lastName,
      required this.aboutMeFileDe,
      required this.aboutMeFileEn,
      required this.assetPathImgOfMe}) {
    myName = "$firstName $lastName";
  }
  UserSettings.fromJsonFile(Map<String, dynamic> userSettingsJson)
      : businessEmail = userSettingsJson['businessEmail'] as String,
        myQuotation = userSettingsJson['myQuotation'] as String,
        firstName = userSettingsJson['firstName'] as String,
        lastName = userSettingsJson['lastName'] as String,
        assetPathImgOfMe = userSettingsJson['assetPathImgOfMe'] as String,
        aboutMeFileDe = userSettingsJson['aboutMeFileDe'] as String,
        aboutMeFileEn = userSettingsJson['aboutMeFileEn'] as String {
    myName = "$firstName $lastName";
    Map<String, dynamic> socialMediaLinksConfigAsJsonMap =
        userSettingsJson['socialMediaLinksConfig'] as Map<String, dynamic>;
    socialMediaLinksConfig = socialMediaLinksConfigAsJsonMap.map((key, value) =>
        MapEntry<String, ExternalLinkConfig>(
            key, ExternalLinkConfig(host: value["host"], path: value["path"])));
  }
  Map<String, ExternalLinkConfig>? socialMediaLinksConfig;
  String? businessEmail;
  String? myQuotation;
  String? firstName;
  String? lastName;
  String? myName;
  String? assetPathImgOfMe;
  String? aboutMeFileDe;
  String? aboutMeFileEn;

  ExternalLinkConfig getFullPathToGithubRepo(String repo) {
    ExternalLinkConfig github = socialMediaLinksConfig!["GitHub"]!;
    github.path += repo;
    return github;
  }
}
