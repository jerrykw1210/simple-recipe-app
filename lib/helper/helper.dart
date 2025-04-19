import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Helper {
  static Directory? _directory;

  static Future<void> initializeDirectory() async {
    _directory ??=
        Platform.isIOS
            ? await getApplicationDocumentsDirectory()
            : await getDownloadsDirectory();
  }

  /// Synchronously get the directory after initialization
  static Directory? get directory {
    if (_directory == null) {
      throw Exception(
        "DirectoryHelper not initialized. Call initialize() first.",
      );
    }
    return _directory;
  }
}
