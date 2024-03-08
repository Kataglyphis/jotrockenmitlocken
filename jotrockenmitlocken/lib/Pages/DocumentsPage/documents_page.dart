import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document_table.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/nav_bar_pages_factory.dart';

class DocumentPage extends NavBarPagesFactory {
  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    List<Document> docs = [
      Document(
        'CV_Jonas_Heinle_english.pdf',
        '~3.7MB English',
      ),
      Document(
        'CV_Jonas_Heinle_german.pdf',
        '~3.7MB German',
      ),
      Document('Bachelor_Thesis.pdf', '~33MB German')
    ];
    return LayoutManager.createSinglePage([
      DocumentTable(
        docs: docs,
      )
    ], appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout);
  }

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: const Icon(Icons.description_outlined),
      label: AppLocalizations.of(context)!.documents,
      selectedIcon: const Icon(Icons.description),
    );
  }
}
