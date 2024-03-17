import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document_table.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';
import 'package:jotrockenmitlocken/Pages/navbar_pages_factory.dart';

class DocumentPage extends NavBarPagesFactory {
  @override
  Widget createPage(AppAttributes appFrameAttributes) {
    List<File> docs = [
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_english.pdf',
        additionalInfo: '~3.7MB English',
      ),
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_german.pdf',
        additionalInfo: '~3.7MB German',
      ),
      File(
          baseDir: 'assets/documents/',
          title: 'Bachelor_Thesis.pdf',
          additionalInfo: '~33MB German')
    ];
    return LayoutManager.createSinglePage(
        [
          DocumentTable(
            docs: docs,
          )
        ],
        JotrockenmitlockenFooter(
            footerPagesConfig:
                JotrockenmitLockenScreenConfigurations.getFooterPagesConfig()),
        appFrameAttributes.showMediumSizeLayout,
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
