import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:jotrockenmitlocken/settings_loader.dart';
import 'package:jotrockenmitlocken/blog_page_config.dart';
import 'package:jotrockenmitlocken/my_two_cents_config.dart';
import 'package:anthology/app_settings.dart';
import 'package:anthology/user_settings.dart';

const _userPath = '/settings/user.json';
const _appPath = '/settings/app.json';
const _blogPath = '/settings/blog.json';
const _twoCentsPath = '/settings/twocents.json';

Map<String, dynamic> _validUserSettingsMap() => {
  'businessEmail': 'test@example.com',
  'myQuotation': 'Carpe diem',
  'firstName': 'John',
  'lastName': 'Doe',
  'assetPathImgOfMe': 'assets/images/me.jpg',
  'aboutMeFileDe': 'assets/documents/about_de.md',
  'aboutMeFileEn': 'assets/documents/about_en.md',
  'socialMediaLinksConfig': {
    'GitHub': {'host': 'github.com', 'path': '/johndoe'},
  },
};

Map<String, dynamic> _validAppSettingsMap() => {
  'appNameDe': 'MeinBlog',
  'appNameEn': 'MyBlog',
  'appTitleDe': 'Willkommen',
  'appTitleEn': 'Welcome',
  'disableFooter': false,
  'supportedLocales': ['de', 'en'],
};

List<Map<String, dynamic>> _validBlogSettingsList() => [
  {
    'routingName': '/myBlog',
    'shortDescriptionEN': 'A short description',
    'shortDescriptionDE': 'Eine kurze Beschreibung',
    'filePath': 'assets/documents/blog/myBlog.md',
    'imageDir': 'assets/images/myBlog',
    'githubRepo': 'myRepo',
    'landingPageAlignment': 'left',
    'landingPageEntryImagePath': 'assets/images/myBlog/entry.jpg',
    'landingPageEntryImageCaptioning': 'Image caption',
    'lastModified': '01.01.2024',
    'fileTitle': 'MyBlog.pdf',
    'fileAdditionalInfo': 'PDF version',
    'fileBaseDir': 'assets/documents/blog/',
    'docsDesc': <dynamic>[],
  },
];

List<Map<String, dynamic>> _validTwoCentsSettingsList() => [
  {
    'routingName': '/books/myBook',
    'filePath': 'assets/documents/books/myBook.md',
    'imageDir': 'assets/images/books',
    'mediaTitle': 'My Awesome Book',
    'fileBaseDir': 'assets/documents/books/',
    'docsDesc': <dynamic>[],
  },
];

Map<String, String> _validMockFiles() => {
  _userPath: jsonEncode(_validUserSettingsMap()),
  _appPath: jsonEncode(_validAppSettingsMap()),
  _blogPath: jsonEncode(_validBlogSettingsList()),
  _twoCentsPath: jsonEncode(_validTwoCentsSettingsList()),
};

SettingsLoader _loaderWith(Map<String, String> mockFiles) {
  return SettingsLoader(
    loadString: (path) async {
      if (!mockFiles.containsKey(path)) {
        throw Exception('Unexpected path: $path');
      }
      return mockFiles[path]!;
    },
  );
}

void main() {
  group('SettingsLoader.loadAll', () {
    test('all 4 JSON files valid → returns correct tuple types', () async {
      final loader = _loaderWith(_validMockFiles());

      final result = await loader.loadAll(
        userSettingsPath: _userPath,
        appSettingsPath: _appPath,
        blogSettingsPath: _blogPath,
        twoCentsSettingsPath: _twoCentsPath,
      );

      expect(result.$1, isA<AppSettings>());
      expect(result.$2, isA<UserSettings>());
      expect(result.$3, isA<List<BlogPageConfig>>());
      expect(result.$4, isA<List<MyTwoCentsConfig>>());
    });

    test('all 4 JSON files valid → values match injected data', () async {
      final loader = _loaderWith(_validMockFiles());

      final result = await loader.loadAll(
        userSettingsPath: _userPath,
        appSettingsPath: _appPath,
        blogSettingsPath: _blogPath,
        twoCentsSettingsPath: _twoCentsPath,
      );

      final appSettings = result.$1;
      final userSettings = result.$2;
      final blogConfigs = result.$3;
      final twoCentsConfigs = result.$4;

      expect(appSettings.appNameDe, 'MeinBlog');
      expect(appSettings.disableFooter, false);
      expect(userSettings.firstName, 'John');
      expect(userSettings.lastName, 'Doe');
      expect(userSettings.myName, 'John Doe');
      expect(blogConfigs.length, 1);
      expect(blogConfigs.single.routingName, '/myBlog');
      expect(twoCentsConfigs.length, 1);
      expect(twoCentsConfigs.single.routingName, '/books/myBook');
    });

    test('file loading fails → error propagated', () async {
      final error = Exception('Network error');
      final loader = SettingsLoader(
        loadString: (path) async {
          if (path == _blogPath) throw error;
          return (_validMockFiles())[path]!;
        },
      );

      expect(
        () => loader.loadAll(
          userSettingsPath: _userPath,
          appSettingsPath: _appPath,
          blogSettingsPath: _blogPath,
          twoCentsSettingsPath: _twoCentsPath,
        ),
        throwsA(error),
      );
    });

    test('user settings JSON malformed → error with descriptive log', () async {
      final files = Map<String, String>.from(_validMockFiles());
      files[_userPath] = '{invalid json';

      final loader = _loaderWith(files);

      expect(
        () => loader.loadAll(
          userSettingsPath: _userPath,
          appSettingsPath: _appPath,
          blogSettingsPath: _blogPath,
          twoCentsSettingsPath: _twoCentsPath,
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('app settings JSON malformed → error with descriptive log', () async {
      final files = Map<String, String>.from(_validMockFiles());
      files[_appPath] = '{invalid json';

      final loader = _loaderWith(files);

      expect(
        () => loader.loadAll(
          userSettingsPath: _userPath,
          appSettingsPath: _appPath,
          blogSettingsPath: _blogPath,
          twoCentsSettingsPath: _twoCentsPath,
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('blog settings JSON malformed → error with descriptive log', () async {
      final files = Map<String, String>.from(_validMockFiles());
      files[_blogPath] = '{invalid json';

      final loader = _loaderWith(files);

      expect(
        () => loader.loadAll(
          userSettingsPath: _userPath,
          appSettingsPath: _appPath,
          blogSettingsPath: _blogPath,
          twoCentsSettingsPath: _twoCentsPath,
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test(
      'two cents settings JSON malformed → error with descriptive log',
      () async {
        final files = Map<String, String>.from(_validMockFiles());
        files[_twoCentsPath] = '{invalid json';

        final loader = _loaderWith(files);

        expect(
          () => loader.loadAll(
            userSettingsPath: _userPath,
            appSettingsPath: _appPath,
            blogSettingsPath: _blogPath,
            twoCentsSettingsPath: _twoCentsPath,
          ),
          throwsA(isA<FormatException>()),
        );
      },
    );

    test('empty blog settings array → empty list', () async {
      final files = Map<String, String>.from(_validMockFiles());
      files[_blogPath] = jsonEncode(<Map<String, dynamic>>[]);

      final loader = _loaderWith(files);

      final result = await loader.loadAll(
        userSettingsPath: _userPath,
        appSettingsPath: _appPath,
        blogSettingsPath: _blogPath,
        twoCentsSettingsPath: _twoCentsPath,
      );

      expect(result.$3, isEmpty);
    });

    test('empty two cents settings array → empty list', () async {
      final files = Map<String, String>.from(_validMockFiles());
      files[_twoCentsPath] = jsonEncode(<Map<String, dynamic>>[]);

      final loader = _loaderWith(files);

      final result = await loader.loadAll(
        userSettingsPath: _userPath,
        appSettingsPath: _appPath,
        blogSettingsPath: _blogPath,
        twoCentsSettingsPath: _twoCentsPath,
      );

      expect(result.$4, isEmpty);
    });
  });

  group('SettingsLoader with custom loadString', () {
    test('custom loadString is called with correct paths', () async {
      final calledPaths = <String>[];

      final loader = SettingsLoader(
        loadString: (path) async {
          calledPaths.add(path);
          return (_validMockFiles())[path]!;
        },
      );

      await loader.loadAll(
        userSettingsPath: _userPath,
        appSettingsPath: _appPath,
        blogSettingsPath: _blogPath,
        twoCentsSettingsPath: _twoCentsPath,
      );

      expect(calledPaths, contains(_userPath));
      expect(calledPaths, contains(_appPath));
      expect(calledPaths, contains(_blogPath));
      expect(calledPaths, contains(_twoCentsPath));
      expect(calledPaths.length, 4);
    });

    test('can inject custom loader for testing', () async {
      final customContents = {
        _userPath: jsonEncode({
          ..._validUserSettingsMap(),
          'firstName': 'Custom',
          'lastName': 'User',
        }),
        _appPath: jsonEncode({
          ..._validAppSettingsMap(),
          'appNameDe': 'CustomApp',
        }),
        _blogPath: jsonEncode([]),
        _twoCentsPath: jsonEncode([]),
      };

      final loader = SettingsLoader(
        loadString: (path) async {
          return customContents[path]!;
        },
      );

      final result = await loader.loadAll(
        userSettingsPath: _userPath,
        appSettingsPath: _appPath,
        blogSettingsPath: _blogPath,
        twoCentsSettingsPath: _twoCentsPath,
      );

      expect(result.$1.appNameDe, 'CustomApp');
      expect(result.$2.firstName, 'Custom');
      expect(result.$2.lastName, 'User');
      expect(result.$2.myName, 'Custom User');
      expect(result.$3, isEmpty);
      expect(result.$4, isEmpty);
    });
  });
}
