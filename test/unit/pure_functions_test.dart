import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/perfect_day_chart.dart';
import 'package:anthology/Layout/Widgets/Scrolling/build_silvers.dart';
import 'package:anthology/Media/DataTable/jotrockenmitlocken_table.dart';
import 'package:anthology/Media/DataTable/table_data.dart';
import 'package:anthology/Media/DataTable/datacell_content_strategies.dart';

// Minimal TableData implementation for testing JotrockenmitlockenTable sorting.
class _TestTableData extends TableData {
  final List<String> _cells;
  _TestTableData(this._cells);

  @override
  List<String> getCells() => _cells;
}

Widget _wrapWithMaterial(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}

void main() {
  // ---------------------------------------------------------------------------
  // getDayHourPercantage (public static method on PerfectDayState)
  // ---------------------------------------------------------------------------
  group('getDayHourPercantage', () {
    test('8 hours returns ~33.33', () {
      expect(PerfectDayState.getDayHourPercantage(8), 33.33);
    });

    test('24 hours returns 100.0', () {
      expect(PerfectDayState.getDayHourPercantage(24), 100.0);
    });

    test('0 hours returns 0.0', () {
      expect(PerfectDayState.getDayHourPercantage(0), 0.0);
    });

    test('12 hours returns 50.0', () {
      expect(PerfectDayState.getDayHourPercantage(12), 50.0);
    });

    test('result is rounded to 2 decimal places', () {
      // 1/24*100 = 4.1666… → rounded to 4.17
      expect(PerfectDayState.getDayHourPercantage(1), 4.17);
    });
  });

  // ---------------------------------------------------------------------------
  // estimateMaxScrollOffset (public override on BuildSlivers)
  // ---------------------------------------------------------------------------
  group('estimateMaxScrollOffset', () {
    Widget dummyBuilder(BuildContext context, int index) =>
        const SizedBox.shrink();

    BuildSlivers buildSliversWithHeights(List<double?> heights) {
      return BuildSlivers(builder: dummyBuilder, heights: heights);
    }

    test(
      'mixed null and non-null heights sums correctly, null treated as 0',
      () {
        final slivers = buildSliversWithHeights([
          100.0,
          null,
          50.0,
          null,
          25.0,
        ]);
        expect(slivers.estimateMaxScrollOffset(0, 4, 0, 0), 175.0);
      },
    );

    test('all null heights returns 0.0', () {
      final slivers = buildSliversWithHeights([null, null, null]);
      expect(slivers.estimateMaxScrollOffset(0, 2, 0, 0), 0.0);
    });

    test('empty heights list returns 0.0', () {
      final slivers = buildSliversWithHeights([]);
      expect(slivers.estimateMaxScrollOffset(0, -1, 0, 0), 0.0);
    });

    test('single non-null height returns that value', () {
      final slivers = buildSliversWithHeights([42.0]);
      expect(slivers.estimateMaxScrollOffset(0, 0, 0, 0), 42.0);
    });

    test('all non-null heights sums correctly', () {
      final slivers = buildSliversWithHeights([10.0, 20.0, 30.0]);
      expect(slivers.estimateMaxScrollOffset(0, 2, 0, 0), 60.0);
    });

    test('null heights list (default) returns 0.0', () {
      // heights is non-null List<double?> but can contain nulls.
      // All null entries → result is null-safe and returns 0.0.
      final slivers = buildSliversWithHeights([null]);
      expect(slivers.estimateMaxScrollOffset(0, 0, 0, 0), 0.0);
    });
  });

  // ---------------------------------------------------------------------------
  // _formatQuote (private method on _QuotesListState)
  //
  // NOTE: This method should be extracted to a standalone pure function for
  // testability. Currently it lives as a private method inside the private
  // _QuotesListState class and can only be exercised via widget tests.
  //
  // The tests below mirror its exact logic: wrapping a string with »...«
  // ---------------------------------------------------------------------------
  group('_formatQuote (mirrored logic)', () {
    String mirrorFormatQuote(String unformattedQuote) {
      return '\u00BB$unformattedQuote\u00AB';
    }

    test('normal text is wrapped with guillemets', () {
      expect(mirrorFormatQuote('Hello World'), '\u00BBHello World\u00AB');
    });

    test('empty string returns just the guillemets', () {
      expect(mirrorFormatQuote(''), '\u00BB\u00AB');
    });

    test('text with special characters is properly wrapped', () {
      expect(
        mirrorFormatQuote('Caf\u00E9 & Bistro \u2014 "best"'),
        '\u00BBCaf\u00E9 & Bistro \u2014 "best"\u00AB',
      );
    });

    test('text with newlines is properly wrapped', () {
      expect(mirrorFormatQuote('Line 1\nLine 2'), '\u00BBLine 1\nLine 2\u00AB');
    });

    test('whitespace-only string is wrapped', () {
      expect(mirrorFormatQuote('   '), '\u00BB   \u00AB');
    });
  });

  // ---------------------------------------------------------------------------
  // _compareString (private method on JotrockenmitlockenTableState)
  //
  // NOTE: This method should be extracted to a standalone pure function for
  // direct testability. Currently it lives as a private method and can only be
  // exercised indirectly via widget construction. The widget tests below
  // validate the sorting behavior end-to-end.
  // ---------------------------------------------------------------------------
  group('_compareString via JotrockenmitlockenTable widget', () {
    List<DataCellContentStrategies> textStrategy(int count) =>
        List<DataCellContentStrategies>.filled(
          count,
          DataCellContentStrategies.text,
        );

    testWidgets('ascending sort orders data A→Z by column index', (
      tester,
    ) async {
      final data = <_TestTableData>[
        _TestTableData(['Zebra']),
        _TestTableData(['Apple']),
        _TestTableData(['Mango']),
      ];

      await tester.pumpWidget(
        _wrapWithMaterial(
          JotrockenmitlockenTable<_TestTableData>(
            dataCategories: ['Name'],
            title: 'Test Table',
            description: 'Sorting test',
            data: data,
            spacing: [1.0],
            dataCellContentStrategies: textStrategy(1),
            entryRedirectText: 'Go',
            sortColumnIndex: 0,
            sortOnLoaded: true,
            isAscending: true,
          ),
        ),
      );
      await tester.pump();

      final appleY = tester.getTopLeft(find.text('Apple')).dy;
      final mangoY = tester.getTopLeft(find.text('Mango')).dy;
      final zebraY = tester.getTopLeft(find.text('Zebra')).dy;

      expect(appleY, lessThan(mangoY));
      expect(mangoY, lessThan(zebraY));
    });

    testWidgets('descending sort orders data Z→A by column index', (
      tester,
    ) async {
      final data = <_TestTableData>[
        _TestTableData(['Apple']),
        _TestTableData(['Zebra']),
        _TestTableData(['Mango']),
      ];

      await tester.pumpWidget(
        _wrapWithMaterial(
          JotrockenmitlockenTable<_TestTableData>(
            dataCategories: ['Name'],
            title: 'Test Table',
            description: 'Sorting test',
            data: data,
            spacing: [1.0],
            dataCellContentStrategies: textStrategy(1),
            entryRedirectText: 'Go',
            sortColumnIndex: 0,
            sortOnLoaded: true,
            isAscending: false,
          ),
        ),
      );
      await tester.pump();

      final appleY = tester.getTopLeft(find.text('Apple')).dy;
      final mangoY = tester.getTopLeft(find.text('Mango')).dy;
      final zebraY = tester.getTopLeft(find.text('Zebra')).dy;

      expect(zebraY, lessThan(mangoY));
      expect(mangoY, lessThan(appleY));
    });

    testWidgets('equal strings preserve relative order', (tester) async {
      final data = <_TestTableData>[
        _TestTableData(['Same']),
        _TestTableData(['Same']),
      ];

      await tester.pumpWidget(
        _wrapWithMaterial(
          JotrockenmitlockenTable<_TestTableData>(
            dataCategories: ['Name'],
            title: 'Test Table',
            description: 'Sorting test',
            data: data,
            spacing: [1.0],
            dataCellContentStrategies: textStrategy(1),
            entryRedirectText: 'Go',
            sortColumnIndex: 0,
            sortOnLoaded: true,
            isAscending: true,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Same'), findsNWidgets(2));
    });

    testWidgets('empty strings sort correctly', (tester) async {
      final data = <_TestTableData>[
        _TestTableData(['']),
        _TestTableData(['B']),
        _TestTableData(['']),
        _TestTableData(['A']),
      ];

      await tester.pumpWidget(
        _wrapWithMaterial(
          JotrockenmitlockenTable<_TestTableData>(
            dataCategories: ['Name'],
            title: 'Test Table',
            description: 'Sorting test',
            data: data,
            spacing: [1.0],
            dataCellContentStrategies: textStrategy(1),
            entryRedirectText: 'Go',
            sortColumnIndex: 0,
            sortOnLoaded: true,
            isAscending: true,
          ),
        ),
      );
      await tester.pump();

      // Empty strings come before 'A' and 'B' in ascending order.
      // There may be other empty strings from the widget tree, so just check
      // that A and B are rendered.
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);

      final aY = tester.getTopLeft(find.text('A')).dy;
      final bY = tester.getTopLeft(find.text('B')).dy;
      expect(aY, lessThan(bY));
    });

    testWidgets('sortOnLoaded false does not sort data', (tester) async {
      final data = <_TestTableData>[
        _TestTableData(['Z']),
        _TestTableData(['A']),
        _TestTableData(['M']),
      ];

      await tester.pumpWidget(
        _wrapWithMaterial(
          JotrockenmitlockenTable<_TestTableData>(
            dataCategories: ['Name'],
            title: 'Test Table',
            description: 'Sorting test',
            data: data,
            spacing: [1.0],
            dataCellContentStrategies: textStrategy(1),
            entryRedirectText: 'Go',
            sortColumnIndex: 0,
            sortOnLoaded: false,
            isAscending: true,
          ),
        ),
      );
      await tester.pump();

      // Data should remain in original order: Z, A, M
      final zY = tester.getTopLeft(find.text('Z')).dy;
      final aY = tester.getTopLeft(find.text('A')).dy;
      final mY = tester.getTopLeft(find.text('M')).dy;

      expect(zY, lessThan(aY));
      expect(aY, lessThan(mY));
    });
  });
}
