import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/books_list.dart';
import 'package:jotrockenmitlocken/blog_dependent_app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/csv_data_page.dart';

class BooksPage extends StatelessWidget {
  final AppAttributes appAttributes;
  final BlogDependentAppAttributes blogDependentAppAttributes;
  final Footer footer;
  const BooksPage({
    super.key,
    required this.appAttributes,
    required this.footer,
    required this.blogDependentAppAttributes,
  });

  @override
  Widget build(BuildContext context) {
    return CsvDataPage(
      appAttributes: appAttributes,
      footer: footer,
      child: BooksList(
        blogDependentAppAttributes: blogDependentAppAttributes,
        entryRedirectText: AppLocalizations.of(context)!.entryRedirectText,
        appAttributes: appAttributes,
        title: AppLocalizations.of(context)!.books,
        description:
            "${AppLocalizations.of(context)!.booksDescription}\u{1F63A}",
        dataFilePath: "assets/data/Buecherliste_gelesen.csv",
      ),
    );
  }
}
