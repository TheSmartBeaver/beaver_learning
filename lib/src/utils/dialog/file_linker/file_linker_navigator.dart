import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FileLinkerNavigatorMenuItem { SEARCH_FILES, FILES_LINKED, IMPORT_FILE }

class FileLinkerNavigator extends ConsumerStatefulWidget {

  final int numberOfFilesLinked;
  final Function(FileLinkerNavigatorMenuItem)? onLinkNavigItemChange;

  FileLinkerNavigator({super.key, required this.numberOfFilesLinked, this.onLinkNavigItemChange});

  @override
  ConsumerState<FileLinkerNavigator> createState() {
    return _FileLinkerNavigatorState();
  }
}

class _FileLinkerNavigatorState extends ConsumerState<FileLinkerNavigator> {
  int currentIndex = 0;
  void selectQgWidget(int index) {
    setState(() {
      currentIndex = index;
      switch (index) {
        case 0:
          widget.onLinkNavigItemChange!(FileLinkerNavigatorMenuItem.IMPORT_FILE);
          break;
        case 1:
          widget.onLinkNavigItemChange!(FileLinkerNavigatorMenuItem.SEARCH_FILES);
          break;
        case 2:
          widget.onLinkNavigItemChange!(FileLinkerNavigatorMenuItem.FILES_LINKED);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.redAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BottomNavigationBar(
          onTap: selectQgWidget,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.import_export_sharp),
              label: 'Import a file from storage',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search files',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                  label: Text(widget.numberOfFilesLinked.toString()), // Nombre de notifications non lues
                  child: const Icon(Icons.business_center)),
              label: 'Files linked',
            ),
          ],
          currentIndex:
              currentIndex),
    );
  }
}
