import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Sqlite/sqlite_self_test.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class SqliteTestPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;

  const SqliteTestPage({
    super.key,
    required this.appAttributes,
    required this.footer,
  });

  @override
  State<StatefulWidget> createState() => SqliteTestPageState();
}

class SqliteTestPageState extends State<SqliteTestPage> {
  bool _isRunning = false;
  String? _result;

  Future<void> _run() async {
    setState(() {
      _isRunning = true;
      _result = null;
    });

    String result;
    try {
      result = await runSqliteSelfTest();
    } catch (e) {
      result = 'FEHLER: $e';
    }

    if (!mounted) return;
    setState(() {
      _isRunning = false;
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline = (Localizations.localeOf(context) == const Locale('de'))
        ? 'SQLite Self-Test'
        : 'SQLite self test';

    final description = (Localizations.localeOf(context) == const Locale('de'))
        ? 'Führt eine minimale Query aus und zeigt das Ergebnis.'
        : 'Runs a minimal query and shows the result.';

    return SinglePage(
      footer: widget.footer,
      appAttributes: widget.appAttributes,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(headline, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(description, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: _isRunning ? null : _run,
              child: Text(
                _isRunning
                    ? ((Localizations.localeOf(context) == const Locale('de'))
                          ? 'Läuft…'
                          : 'Running…')
                    : ((Localizations.localeOf(context) == const Locale('de'))
                          ? 'Test ausführen'
                          : 'Run test'),
              ),
            ),
            const SizedBox(height: 16),
            if (_result != null)
              SelectableText(
                _result!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
          ],
        ),
      ],
    );
  }
}
