import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';
import 'package:youtube/adaptive_root.dart';
import 'package:youtube/tracks_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (UniversalPlatform.isDesktop) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: 'Flutter Audio Player',
      size: Size(380, 740),
      alwaysOnTop: true,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () {});
  }

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    ProviderScope(
      child: buildApp(savedThemeMode: savedThemeMode),
    ),
  );
}

AdaptiveRoot buildApp({AdaptiveThemeMode? savedThemeMode}) => AdaptiveRoot(
      savedThemeMode: savedThemeMode,
      appTitle: 'Flutter Audio Player',
      debugShowFloatingThemeButton: false,
    );

final playingStateProvider = StateProvider<bool>((ref) {
  return false;
});

final settingsState = StateProvider<bool>((ref) {
  return false;
});

final listFileEntityProvider = StateProvider<List<FileSystemEntity>>((ref) {
  if (!UniversalPlatform.isWeb) {
    final list = [
      File('assets/Web Audio Files/Titanium.mp3'),
      File('assets/Web Audio Files/Glossy.mp3'),
      File('assets/Web Audio Files/Chill.mp3'),
      File('assets/Web Audio Files/Space.mp3'),
      File('assets/Web Audio Files/Awaken.mp3'),
    ];
    return list;
    //If universal platform is web, then import assets/assets/Web Audio Files with assets doubling. If not, then import assets/Web Audio Files without assets doubling.
  } else {
    final list = [
      File('assets/assets/WebAudioFiles/Titanium.mp3'),
      File('assets/assets/WebAudioFiles/Glossy.mp3'),
      File('assets/assets/WebAudioFiles/Chill.mp3'),
      File('assets/assets/WebAudioFiles/Space.mp3'),
      File('assets/assets/WebAudioFiles/Awaken.mp3'),
    ];
    return list;
  }
});

final audioFilesProvider = FutureProvider<List<FileSystemEntity>>((ref) async {
  if (!UniversalPlatform.isWindows) {
    final audioFiles = [
      File('assets/assets/WebAudioFiles/Titanium.mp3'),
      File('assets/assets/WebAudioFiles/Glossy.mp3'),
      File('assets/assets/WebAudioFiles/Chill.mp3'),
      File('assets/assets/WebAudioFiles/Space.mp3'),
      File('assets/assets/WebAudioFiles/Awaken.mp3'),
    ];

    //ref.read(listFileEntityProvider.notifier).state = audioFiles;
    return audioFiles;
  } else if (await Permission.storage.request().isGranted) {
    Directory directory = Directory.current;
    List<FileSystemEntity> files = [];

    if (UniversalPlatform.isWindows) {
      directory =
          Directory('C:/Users/${Platform.environment['USERNAME']}/Music');
      files = directory.listSync();
    } else if (UniversalPlatform.isAndroid) {
      directory = Directory('/storage/emulated/0/Music');
      files = directory.listSync();
    }

    final audioFiles = files
        .where((file) =>
            file.path.endsWith('.m4a') ||
            file.path.endsWith('.mp3') ||
            file.path.endsWith('.wav'))
        .toList();
    ref.read(totalSongsProvider.notifier).state = audioFiles.length;
    ref.read(listFileEntityProvider.notifier).state = audioFiles;

    return audioFiles;
  }
  return <FileSystemEntity>[];
});
