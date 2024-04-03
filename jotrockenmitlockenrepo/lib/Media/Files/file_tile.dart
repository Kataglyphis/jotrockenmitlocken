import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Media/Download/download_file_icon.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Media/Open/open_button.dart';

class FileTile extends StatelessWidget {
  const FileTile({super.key, required this.currentDocument});
  final File currentDocument;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      child: ListTile(
        dense: true,
        leading: FileDownloadIcon(document: currentDocument),
        title: Text(
          currentDocument.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          currentDocument.additionalInfo,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: OpenButton(
          assetFullPath: currentDocument.baseDir + currentDocument.title,
        ),
      ),
    );
  }
}
