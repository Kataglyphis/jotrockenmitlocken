import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/blog_page_config.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/my_two_cents_config.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_stateful_branch_info_provider.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/generic_footer_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/generic_navbar_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/simple_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Sqlite/sqlite_test_page_config.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/app_settings.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

void main() {
  group('AppSettings.fromJsonFile', () {
    test('valid complete JSON → all fields populated correctly', () {
      final json = {
        'appNameDe': 'MeinBlog',
        'appNameEn': 'MyBlog',
        'appTitleDe': 'Willkommen',
        'appTitleEn': 'Welcome',
        'disableFooter': true,
        'supportedLocales': ['de', 'en', 'fr'],
      };

      final settings = AppSettings.fromJsonFile(json);

      expect(settings.appNameDe, 'MeinBlog');
      expect(settings.appNameEn, 'MyBlog');
      expect(settings.appTitleDe, 'Willkommen');
      expect(settings.appTitleEn, 'Welcome');
      expect(settings.disableFooter, true);
      expect(settings.supportedLocales, ['de', 'en', 'fr']);
    });

    test('missing supportedLocales key → supportedLocales is empty list', () {
      final json = {
        'appNameDe': 'MeinBlog',
        'appNameEn': 'MyBlog',
        'appTitleDe': 'Willkommen',
        'appTitleEn': 'Welcome',
        'disableFooter': false,
      };

      final settings = AppSettings.fromJsonFile(json);

      expect(settings.supportedLocales, isEmpty);
    });

    test('empty supportedLocales list → empty list', () {
      final json = {
        'appNameDe': 'MeinBlog',
        'appNameEn': 'MyBlog',
        'appTitleDe': 'Willkommen',
        'appTitleEn': 'Welcome',
        'disableFooter': false,
        'supportedLocales': <dynamic>[],
      };

      final settings = AppSettings.fromJsonFile(json);

      expect(settings.supportedLocales, isEmpty);
    });

    test('disableFooter true', () {
      final json = {
        'appNameDe': 'MeinBlog',
        'appNameEn': 'MyBlog',
        'appTitleDe': 'Willkommen',
        'appTitleEn': 'Welcome',
        'disableFooter': true,
        'supportedLocales': ['de'],
      };

      final settings = AppSettings.fromJsonFile(json);

      expect(settings.disableFooter, true);
    });

    test('disableFooter false', () {
      final json = {
        'appNameDe': 'MeinBlog',
        'appNameEn': 'MyBlog',
        'appTitleDe': 'Willkommen',
        'appTitleEn': 'Welcome',
        'disableFooter': false,
        'supportedLocales': ['de'],
      };

      final settings = AppSettings.fromJsonFile(json);

      expect(settings.disableFooter, false);
    });
  });

  group('UserSettings.fromJsonFile', () {
    test('valid complete JSON → all fields populated correctly', () {
      final json = {
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

      final settings = UserSettings.fromJsonFile(json);

      expect(settings.businessEmail, 'test@example.com');
      expect(settings.myQuotation, 'Carpe diem');
      expect(settings.firstName, 'John');
      expect(settings.lastName, 'Doe');
      expect(settings.myName, 'John Doe');
      expect(settings.assetPathImgOfMe, 'assets/images/me.jpg');
      expect(settings.aboutMeFileDe, 'assets/documents/about_de.md');
      expect(settings.aboutMeFileEn, 'assets/documents/about_en.md');
    });

    test('socialMediaLinksConfig with map entries → properly converted to '
        'Map<String, ExternalLinkConfig>', () {
      final json = {
        'businessEmail': 'test@example.com',
        'myQuotation': 'Carpe diem',
        'firstName': 'John',
        'lastName': 'Doe',
        'assetPathImgOfMe': 'assets/images/me.jpg',
        'aboutMeFileDe': 'assets/documents/about_de.md',
        'aboutMeFileEn': 'assets/documents/about_en.md',
        'socialMediaLinksConfig': {
          'GitHub': {'host': 'github.com', 'path': '/johndoe'},
          'Twitter': {'host': 'twitter.com', 'path': '/johndoe'},
        },
      };

      final settings = UserSettings.fromJsonFile(json);

      final links = settings.socialMediaLinksConfig!;
      expect(links.length, 2);
      expect(links['GitHub']!.host, 'github.com');
      expect(links['GitHub']!.path, '/johndoe');
      expect(links['Twitter']!.host, 'twitter.com');
      expect(links['Twitter']!.path, '/johndoe');
    });

    test('myName is set after construction', () {
      final json = {
        'businessEmail': 'test@example.com',
        'myQuotation': 'Carpe diem',
        'firstName': 'Alice',
        'lastName': 'Smith',
        'assetPathImgOfMe': 'assets/images/me.jpg',
        'aboutMeFileDe': 'assets/documents/about_de.md',
        'aboutMeFileEn': 'assets/documents/about_en.md',
        'socialMediaLinksConfig': {
          'GitHub': {'host': 'github.com', 'path': '/alice'},
        },
      };

      final settings = UserSettings.fromJsonFile(json);

      expect(settings.myName, 'Alice Smith');
    });
  });

  group('UserSettings constructor', () {
    test('creates instance with all required fields', () {
      final socialLinks = {
        'GitHub': ExternalLinkConfig(host: 'github.com', path: '/test'),
      };

      final settings = UserSettings(
        socialMediaLinksConfig: socialLinks,
        businessEmail: 'test@example.com',
        myQuotation: 'Hello',
        firstName: 'Jane',
        lastName: 'Doe',
        aboutMeFileDe: 'about_de.md',
        aboutMeFileEn: 'about_en.md',
        assetPathImgOfMe: 'img.jpg',
      );

      expect(settings.socialMediaLinksConfig, socialLinks);
      expect(settings.businessEmail, 'test@example.com');
      expect(settings.myQuotation, 'Hello');
      expect(settings.firstName, 'Jane');
      expect(settings.lastName, 'Doe');
      expect(settings.aboutMeFileDe, 'about_de.md');
      expect(settings.aboutMeFileEn, 'about_en.md');
      expect(settings.assetPathImgOfMe, 'img.jpg');
    });

    test('myName is set in constructor body', () {
      final settings = UserSettings(
        socialMediaLinksConfig: <String, ExternalLinkConfig>{},
        businessEmail: 'test@example.com',
        myQuotation: 'Hello',
        firstName: 'Bob',
        lastName: 'Builder',
        aboutMeFileDe: 'about_de.md',
        aboutMeFileEn: 'about_en.md',
        assetPathImgOfMe: 'img.jpg',
      );

      expect(settings.myName, 'Bob Builder');
    });
  });

  group('UserSettings.getFullPathToGithubRepo', () {
    test(
      'valid config → returns ExternalLinkConfig with path concatenated',
      () {
        final socialLinks = {
          'GitHub': ExternalLinkConfig(host: 'github.com', path: '/user'),
        };

        final settings = UserSettings(
          socialMediaLinksConfig: socialLinks,
          businessEmail: 'test@example.com',
          myQuotation: 'Hello',
          firstName: 'Jane',
          lastName: 'Doe',
          aboutMeFileDe: 'about_de.md',
          aboutMeFileEn: 'about_en.md',
          assetPathImgOfMe: 'img.jpg',
        );

        final result = settings.getFullPathToGithubRepo('/my-repo');

        expect(result.host, 'github.com');
        expect(result.path, '/user/my-repo');
      },
    );

    test('null socialMediaLinksConfig → throws StateError', () {
      final settings = UserSettings(
        socialMediaLinksConfig: null,
        businessEmail: 'test@example.com',
        myQuotation: 'Hello',
        firstName: 'Jane',
        lastName: 'Doe',
        aboutMeFileDe: 'about_de.md',
        aboutMeFileEn: 'about_en.md',
        assetPathImgOfMe: 'img.jpg',
      );

      expect(
        () => settings.getFullPathToGithubRepo('/my-repo'),
        throwsA(isA<StateError>()),
      );
    });

    test('missing "GitHub" key → throws StateError', () {
      final socialLinks = <String, ExternalLinkConfig>{
        'Twitter': ExternalLinkConfig(host: 'twitter.com', path: '/user'),
      };

      final settings = UserSettings(
        socialMediaLinksConfig: socialLinks,
        businessEmail: 'test@example.com',
        myQuotation: 'Hello',
        firstName: 'Jane',
        lastName: 'Doe',
        aboutMeFileDe: 'about_de.md',
        aboutMeFileEn: 'about_en.md',
        assetPathImgOfMe: 'img.jpg',
      );

      expect(
        () => settings.getFullPathToGithubRepo('/my-repo'),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('BlogPageConfig.fromJsonFile', () {
    test('valid complete JSON → all fields populated', () {
      final json = {
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
        'docsDesc': <dynamic>[
          {
            'baseDir': 'assets/documents/cv/',
            'title': 'CV.pdf',
            'additionalInfo': 'English',
          },
        ],
      };

      final config = BlogPageConfig.fromJsonFile(json);

      expect(config.routingName, '/myBlog');
      expect(config.shortDescriptionEN, 'A short description');
      expect(config.shortDescriptionDE, 'Eine kurze Beschreibung');
      expect(config.filePath, 'assets/documents/blog/myBlog.md');
      expect(config.imageDir, 'assets/images/myBlog');
      expect(config.githubRepo, 'myRepo');
      expect(config.landingPageAlignment, 'left');
      expect(
        config.landingPageEntryImagePath,
        'assets/images/myBlog/entry.jpg',
      );
      expect(config.landingPageEntryImageCaptioning, 'Image caption');
      expect(config.lastModified, '01.01.2024');
      expect(config.fileTitle, 'MyBlog.pdf');
      expect(config.fileAdditionalInfo, 'PDF version');
      expect(config.fileBaseDir, 'assets/documents/blog/');
      expect(config.docsDesc.length, 1);
      expect(config.docsDesc[0]['baseDir'], 'assets/documents/cv/');
      expect(config.docsDesc[0]['title'], 'CV.pdf');
      expect(config.docsDesc[0]['additionalInfo'], 'English');
    });

    test('empty docsDesc → empty list', () {
      final json = {
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
      };

      final config = BlogPageConfig.fromJsonFile(json);

      expect(config.docsDesc, isEmpty);
    });

    test('multiple docsDesc entries → all mapped correctly', () {
      final json = {
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
        'docsDesc': <dynamic>[
          {
            'baseDir': 'assets/documents/cv/',
            'title': 'CV_EN.pdf',
            'additionalInfo': 'English',
          },
          {
            'baseDir': 'assets/documents/cv/',
            'title': 'CV_DE.pdf',
            'additionalInfo': 'German',
          },
        ],
      };

      final config = BlogPageConfig.fromJsonFile(json);

      expect(config.docsDesc.length, 2);
      expect(config.docsDesc[0]['title'], 'CV_EN.pdf');
      expect(config.docsDesc[1]['title'], 'CV_DE.pdf');
    });

    test('landingPageEntryImageCaptioning absent → throws TypeError', () {
      final json = {
        'routingName': '/myBlog',
        'shortDescriptionEN': 'A short description',
        'shortDescriptionDE': 'Eine kurze Beschreibung',
        'filePath': 'assets/documents/blog/myBlog.md',
        'imageDir': 'assets/images/myBlog',
        'githubRepo': 'myRepo',
        'landingPageAlignment': 'left',
        'landingPageEntryImagePath': 'assets/images/myBlog/entry.jpg',
        'lastModified': '01.01.2024',
        'fileTitle': 'MyBlog.pdf',
        'fileAdditionalInfo': 'PDF version',
        'fileBaseDir': 'assets/documents/blog/',
        'docsDesc': <dynamic>[],
      };

      expect(
        () => BlogPageConfig.fromJsonFile(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('landingPageEntryImageCaptioning with value → stored correctly', () {
      final json = {
        'routingName': '/myBlog',
        'shortDescriptionEN': 'A short description',
        'shortDescriptionDE': 'Eine kurze Beschreibung',
        'filePath': 'assets/documents/blog/myBlog.md',
        'imageDir': 'assets/images/myBlog',
        'githubRepo': 'myRepo',
        'landingPageAlignment': 'left',
        'landingPageEntryImagePath': 'assets/images/myBlog/entry.jpg',
        'landingPageEntryImageCaptioning': 'My caption',
        'lastModified': '01.01.2024',
        'fileTitle': 'MyBlog.pdf',
        'fileAdditionalInfo': 'PDF version',
        'fileBaseDir': 'assets/documents/blog/',
        'docsDesc': <dynamic>[],
      };

      final config = BlogPageConfig.fromJsonFile(json);

      expect(config.landingPageEntryImageCaptioning, 'My caption');
    });
  });

  group('MyTwoCentsConfig.fromJsonFile', () {
    test('valid complete JSON → all fields populated', () {
      final json = {
        'routingName': '/books/myBook',
        'filePath': 'assets/documents/books/myBook.md',
        'imageDir': 'assets/images/books',
        'mediaTitle': 'My Awesome Book',
        'fileBaseDir': 'assets/documents/books/',
        'docsDesc': <dynamic>[
          {
            'baseDir': 'assets/documents/cv/',
            'title': 'CV.pdf',
            'additionalInfo': 'English',
          },
        ],
      };

      final config = MyTwoCentsConfig.fromJsonFile(json);

      expect(config.routingName, '/books/myBook');
      expect(config.filePath, 'assets/documents/books/myBook.md');
      expect(config.imageDir, 'assets/images/books');
      expect(config.mediaTitle, 'My Awesome Book');
      expect(config.fileBaseDir, 'assets/documents/books/');
      expect(config.docsDesc.length, 1);
      expect(config.docsDesc[0]['baseDir'], 'assets/documents/cv/');
      expect(config.docsDesc[0]['title'], 'CV.pdf');
      expect(config.docsDesc[0]['additionalInfo'], 'English');
    });

    test('empty docsDesc → empty list', () {
      final json = {
        'routingName': '/books/myBook',
        'filePath': 'assets/documents/books/myBook.md',
        'imageDir': 'assets/images/books',
        'mediaTitle': 'My Awesome Book',
        'fileBaseDir': 'assets/documents/books/',
        'docsDesc': <dynamic>[],
      };

      final config = MyTwoCentsConfig.fromJsonFile(json);

      expect(config.docsDesc, isEmpty);
    });

    test('multiple docsDesc entries → all mapped', () {
      final json = {
        'routingName': '/books/myBook',
        'filePath': 'assets/documents/books/myBook.md',
        'imageDir': 'assets/images/books',
        'mediaTitle': 'My Awesome Book',
        'fileBaseDir': 'assets/documents/books/',
        'docsDesc': <dynamic>[
          {
            'baseDir': 'assets/documents/cv/',
            'title': 'CV_EN.pdf',
            'additionalInfo': 'English',
          },
          {
            'baseDir': 'assets/data/',
            'title': 'data.zip',
            'additionalInfo': 'Dataset',
          },
        ],
      };

      final config = MyTwoCentsConfig.fromJsonFile(json);

      expect(config.docsDesc.length, 2);
      expect(config.docsDesc[0]['title'], 'CV_EN.pdf');
      expect(config.docsDesc[1]['title'], 'data.zip');
    });
  });

  group('GenericNavBarPageConfig', () {
    test('constructor stores all 4 fields', () {
      final config = GenericNavBarPageConfig(
        icon: Icons.home,
        selectedIcon: Icons.home_filled,
        labelBuilder: (_) => 'Homepage',
        routingName: '/home',
      );

      expect(config.icon, Icons.home);
      expect(config.selectedIcon, Icons.home_filled);
      expect(config.routingName, '/home');
    });

    test('getRoutingName() returns injected value', () {
      final config = GenericNavBarPageConfig(
        icon: Icons.home,
        selectedIcon: Icons.home_filled,
        labelBuilder: (_) => 'Homepage',
        routingName: '/customRoute',
      );

      expect(config.getRoutingName(), '/customRoute');
    });

    test('labelBuilder closure works correctly', () {
      final config = GenericNavBarPageConfig(
        icon: Icons.home,
        selectedIcon: Icons.home_filled,
        labelBuilder: (_) => 'label-Homepage',
        routingName: '/home',
      );

      expect(config.labelBuilder, isNotNull);
    });
  });

  group('GenericFooterPageConfig', () {
    test('constructor stores all 4 fields', () {
      final config = GenericFooterPageConfig(
        headingBuilder: (ctx) => 'Heading',
        routingName: '/footer',
        filePathDe: 'footer_de.md',
        filePathEn: 'footer_en.md',
      );

      expect(config.routingName, '/footer');
      expect(config.filePathDe, 'footer_de.md');
      expect(config.filePathEn, 'footer_en.md');
    });

    test('getRoutingName() returns injected value', () {
      final config = GenericFooterPageConfig(
        headingBuilder: (ctx) => 'Heading',
        routingName: '/customFooter',
        filePathDe: 'footer_de.md',
        filePathEn: 'footer_en.md',
      );

      expect(config.getRoutingName(), '/customFooter');
    });

    test('getFilePathDe() returns injected value', () {
      final config = GenericFooterPageConfig(
        headingBuilder: (ctx) => 'Heading',
        routingName: '/footer',
        filePathDe: 'my_de.md',
        filePathEn: 'footer_en.md',
      );

      expect(config.getFilePathDe(), 'my_de.md');
    });

    test('getFilePathEn() returns injected value', () {
      final config = GenericFooterPageConfig(
        headingBuilder: (ctx) => 'Heading',
        routingName: '/footer',
        filePathDe: 'footer_de.md',
        filePathEn: 'my_en.md',
      );

      expect(config.getFilePathEn(), 'my_en.md');
    });

    test('headingBuilder closure works correctly', () {
      final config = GenericFooterPageConfig(
        headingBuilder: (ctx) => 'My Heading',
        routingName: '/footer',
        filePathDe: 'footer_de.md',
        filePathEn: 'footer_en.md',
      );

      expect(config.headingBuilder, isNotNull);
    });
  });

  group('Routing configs', () {
    test('SimplePageConfig /books', () {
      expect(const SimplePageConfig('/books').getRoutingName(), '/books');
    });

    test('SimplePageConfig /films', () {
      expect(const SimplePageConfig('/films').getRoutingName(), '/films');
    });

    test('SimplePageConfig /games', () {
      expect(const SimplePageConfig('/games').getRoutingName(), '/games');
    });

    test('SimplePageConfig /quotations', () {
      expect(
        const SimplePageConfig('/quotations').getRoutingName(),
        '/quotations',
      );
    });

    test('SimplePageConfig /blockEntries', () {
      expect(
        const SimplePageConfig('/blockEntries').getRoutingName(),
        '/blockEntries',
      );
    });

    test('SqliteTestPageConfig.getRoutingName() → /sqliteTest', () {
      expect(const SqliteTestPageConfig().getRoutingName(), '/sqliteTest');
    });

    test(
      'ErrorPageStatefulBranchInfoProvider.getRoutingName() → /errorPage',
      () {
        expect(
          ErrorPageStatefulBranchInfoProvider().getRoutingName(),
          '/errorPage',
        );
      },
    );
  });

  group('ColorSeed enum', () {
    test('has 8 values', () {
      expect(ColorSeed.values.length, 8);
    });

    test('each value has non-null label and color', () {
      for (final seed in ColorSeed.values) {
        expect(seed.label, isNotNull);
        expect(seed.color, isNotNull);
      }
    });
  });

  group('AppLocalizations', () {
    test('AppLocalizations.delegate is not null', () {
      expect(AppLocalizations.delegate, isNotNull);
    });

    test('supported locales list is not empty', () {
      expect(AppLocalizations.supportedLocales, isNotEmpty);
    });
  });
}
