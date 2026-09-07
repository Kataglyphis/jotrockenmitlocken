import 'dart:convert' show json;
import 'dart:developer' as developer;

import 'package:flutter/services.dart' show rootBundle;

import 'package:anthology/blog_page_config.dart';
import 'package:anthology/my_two_cents_config.dart';
import 'package:anthology/app_settings.dart';
import 'package:anthology/user_settings.dart';

typedef SettingsLoadResult = (
  AppSettings,
  UserSettings,
  List<BlogPageConfig>,
  List<MyTwoCentsConfig>,
);

class SettingsLoader {
  final Future<String> Function(String path) _loadString;

  SettingsLoader({Future<String> Function(String)? loadString})
    : _loadString = loadString ?? rootBundle.loadString;

  Future<SettingsLoadResult> loadAll({
    required String userSettingsPath,
    required String appSettingsPath,
    required String blogSettingsPath,
    required String twoCentsSettingsPath,
  }) async {
    final List<String> results;
    try {
      results = await Future.wait([
        _loadString(userSettingsPath),
        _loadString(appSettingsPath),
        _loadString(blogSettingsPath),
        _loadString(twoCentsSettingsPath),
      ]);
    } catch (e) {
      developer.log(
        'Failed to load settings files: $e',
        name: 'SettingsLoader.loadAll',
        error: e,
      );
      rethrow;
    }

    final userSettings = _parseUserSettings(results[0]);
    final appSettings = _parseAppSettings(results[1]);
    final blogConfigs = _parseBlogSettings(results[2]);
    final twoCentsConfigs = _parseTwoCentsSettings(results[3]);

    return (appSettings, userSettings, blogConfigs, twoCentsConfigs);
  }

  static UserSettings _parseUserSettings(String jsonString) {
    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      return UserSettings.fromJsonFile(decoded);
    } catch (e) {
      developer.log(
        'Failed to parse user settings JSON: $e',
        name: 'SettingsLoader',
        error: e,
      );
      rethrow;
    }
  }

  static AppSettings _parseAppSettings(String jsonString) {
    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      return AppSettings.fromJsonFile(decoded);
    } catch (e) {
      developer.log(
        'Failed to parse app settings JSON: $e',
        name: 'SettingsLoader',
        error: e,
      );
      rethrow;
    }
  }

  static List<BlogPageConfig> _parseBlogSettings(String jsonString) {
    try {
      final decoded = json.decode(jsonString) as List<dynamic>;
      return decoded
          .map((e) => BlogPageConfig.fromJsonFile(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      developer.log(
        'Failed to parse blog settings JSON: $e',
        name: 'SettingsLoader',
        error: e,
      );
      rethrow;
    }
  }

  static List<MyTwoCentsConfig> _parseTwoCentsSettings(String jsonString) {
    try {
      final decoded = json.decode(jsonString) as List<dynamic>;
      return decoded
          .map((e) => MyTwoCentsConfig.fromJsonFile(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      developer.log(
        'Failed to parse two cents settings JSON: $e',
        name: 'SettingsLoader',
        error: e,
      );
      rethrow;
    }
  }
}
