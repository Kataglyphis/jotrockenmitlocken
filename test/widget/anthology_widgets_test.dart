// Keep the `_test.dart` suffix: package:test discovers nothing else, so a rename silently drops the suite.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anthology/Pages/ErrorPage/error_page_widget.dart';
import 'package:anthology/Decoration/component_group_decoration.dart';
import 'package:anthology/Media/Files/file.dart';
import 'package:anthology/Media/Files/file_table.dart';
import 'package:anthology/Media/Files/file_tile.dart';
import 'package:anthology/l10n/anthology_localizations.dart';

/// Hosts [child] with [AnthologyLocalizations.delegate], without which the widgets throw a null check.
/// The locale is pinned to English so the assertions hold on a German or French machine.
Widget _hostedInApp(Widget child) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AnthologyLocalizations.localizationsDelegates,
    supportedLocales: AnthologyLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  // ---- File model ----
  group('File model', () {
    test('constructor stores baseDir, title, additionalInfo', () {
      final file = File(
        baseDir: 'assets/documents/cv/',
        title: 'CV_Jonas_Heinle_english.pdf',
        additionalInfo: '~3.7MB English',
      );

      expect(file.baseDir, 'assets/documents/cv/');
      expect(file.title, 'CV_Jonas_Heinle_english.pdf');
      expect(file.additionalInfo, '~3.7MB English');
    });

    test('fields are mutable', () {
      final file = File(
        baseDir: 'foo/',
        title: 'original.pdf',
        additionalInfo: '1MB',
      );

      file.baseDir = 'bar/';
      file.title = 'updated.pdf';
      file.additionalInfo = '2MB';

      expect(file.baseDir, 'bar/');
      expect(file.title, 'updated.pdf');
      expect(file.additionalInfo, '2MB');
    });
  });

  // ---- ErrorPageWidget ----
  group('ErrorPageWidget', () {
    Future<void> pumpErrorPage(WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(_hostedInApp(const ErrorPageWidget()));
    }

    testWidgets('renders ComponentGroupDecoration with label "Error 404"', (
      tester,
    ) async {
      await pumpErrorPage(tester);

      expect(find.byType(ComponentGroupDecoration), findsOneWidget);
      expect(find.text('Error 404'), findsOneWidget);
    });

    testWidgets('renders an Image.asset widget', (tester) async {
      await pumpErrorPage(tester);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('structure: ComponentGroupDecoration -> Image.asset', (
      tester,
    ) async {
      await pumpErrorPage(tester);

      final componentGroup = tester.widget<ComponentGroupDecoration>(
        find.byType(ComponentGroupDecoration),
      );

      expect(componentGroup.label, 'Error 404');
      expect(find.byType(Image), findsOneWidget);
    });
  });

  // ---- FileTable ----
  group('FileTable', () {
    testWidgets('empty docs list renders SizedBox (no content)', (
      tester,
    ) async {
      await tester.pumpWidget(
        _hostedInApp(FileTable(docs: <File>[], title: 'Test Documents')),
      );

      expect(find.text('Test Documents'), findsNothing);
      expect(find.byType(FileTile), findsNothing);
    });

    testWidgets('single file renders title + file entry', (tester) async {
      final docs = <File>[
        File(baseDir: 'dir/', title: 'a.pdf', additionalInfo: '1MB'),
      ];

      await tester.pumpWidget(
        _hostedInApp(FileTable(docs: docs, title: 'Documents')),
      );

      expect(find.text('Documents'), findsOneWidget);
      expect(find.byType(FileTile), findsOneWidget);
    });

    testWidgets('multiple files renders all entries', (tester) async {
      final docs = <File>[
        File(baseDir: 'dir/', title: 'a.pdf', additionalInfo: '1MB'),
        File(baseDir: 'dir/', title: 'b.pdf', additionalInfo: '2MB'),
        File(baseDir: 'dir/', title: 'c.pdf', additionalInfo: '3MB'),
      ];

      await tester.pumpWidget(
        _hostedInApp(FileTable(docs: docs, title: 'Documents')),
      );

      expect(find.byType(FileTile), findsNWidgets(3));
      expect(find.text('Documents'), findsOneWidget);
    });

    testWidgets('FileTile receives correct File data', (tester) async {
      final fileData = File(
        baseDir: 'assets/documents/cv/',
        title: 'CV.pdf',
        additionalInfo: '~3MB',
      );

      await tester.pumpWidget(
        _hostedInApp(FileTable(docs: <File>[fileData], title: 'Docs')),
      );

      final fileTile = tester.widget<FileTile>(find.byType(FileTile));

      expect(fileTile.currentDocument.title, 'CV.pdf');
      expect(fileTile.currentDocument.additionalInfo, '~3MB');
      expect(fileTile.currentDocument.baseDir, 'assets/documents/cv/');
    });

    testWidgets('title text is rendered with headlineLarge style', (
      tester,
    ) async {
      await tester.pumpWidget(
        _hostedInApp(
          FileTable(
            docs: <File>[
              File(baseDir: 'd/', title: 'f.pdf', additionalInfo: ''),
            ],
            title: 'Downloads',
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Downloads'));
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.style, isNotNull);
    });

    testWidgets('renders with custom title', (tester) async {
      const customTitle = 'My Custom Downloads';

      await tester.pumpWidget(
        _hostedInApp(
          FileTable(
            docs: <File>[
              File(baseDir: 'd/', title: 'f.pdf', additionalInfo: ''),
            ],
            title: customTitle,
          ),
        ),
      );

      expect(find.text(customTitle), findsOneWidget);
    });

    // Fails by name, not with an anonymous null check, when a host drops AnthologyLocalizations.delegate.
    testWidgets('each row carries the localized Open affordance', (
      tester,
    ) async {
      await tester.pumpWidget(
        _hostedInApp(
          FileTable(
            docs: <File>[
              File(baseDir: 'd/', title: 'f.pdf', additionalInfo: '1MB'),
            ],
            title: 'Downloads',
          ),
        ),
      );

      // 'Open' resolves only through the delegate _hostedInApp installs.
      expect(find.text('Open'), findsOneWidget);
    });
  });
}
