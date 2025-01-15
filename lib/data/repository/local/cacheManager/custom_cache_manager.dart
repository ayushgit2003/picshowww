
import 'dart:async';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CustomCacheManager extends CacheManager {
  static const String key = 'customCache';
  static const int maxDiskSpaceMB = 100; // Max disk space in MB

  static final CustomCacheManager _instance = CustomCacheManager._internal();

  factory CustomCacheManager() {
    return _instance;
  }

  CustomCacheManager._internal()
      : super(
    Config(
      key,
      stalePeriod: const Duration(minutes: 3), // Cache expiration time
      maxNrOfCacheObjects: 100, // Limit to 100 objects
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  ) {
    _startDiskSpaceMonitor(); // Start periodic cleanup
  }


  Future<Directory> _getCacheDirectory() async {
    final dir = await getTemporaryDirectory();
    return Directory('${dir.path}/$key');
  }


  void _startDiskSpaceMonitor() {
    Timer.periodic(const Duration(minutes: 3), (timer) async {
      await _checkAndCleanupDiskSpace();
    });
  }


  Future<void> _checkAndCleanupDiskSpace() async {
    final cacheDir = await _getCacheDirectory();
    if (!await cacheDir.exists()) return;

    int totalSize = 0;
    final files = cacheDir.listSync();

    // Calculate total size of cache directory
    for (var file in files) {
      if (file is File) {
        totalSize += await file.length();
      }
    }

    final totalSizeMB = totalSize / (1024 * 1024); // Convert to MB


    if (totalSizeMB > maxDiskSpaceMB) {
      files.sort((a, b) =>
          a.statSync().modified.compareTo(b.statSync().modified)); // Oldest first
      for (var file in files) {
        if (totalSizeMB <= maxDiskSpaceMB) break;
        if (file is File) {
          totalSize -= await file.length();
          await file.delete();
        }
      }
    }
  }
}
