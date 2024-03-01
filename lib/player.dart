// import 'package:audioplayers/audioplayers.dart';

// class Player {
//   final source = AudioPlayer();
//   String lastSong = '';
//   bool sourceReady = false;
//   bool nowPlaying = false;

//   void play(String filePath) async {
//     await source.setSource(DeviceFileSource(filePath));
//     setLastSong(filePath);
//     setNowPlaying(true);

//     await source.resume();
//     sourceReady = true;
//   }

//   //Δημιούργησε μια μέθοδο όπου δεν θα δέχεται τίποτα και θα κάνει await source.pause();
//   void pause() async {
//     await source.pause();
//   }

//   void resume() async {
//     if (sourceReady == false) {
//       play(getLastSong());
//     }
//     await source.resume();
//   }

//   void dispose() async {
//     await source.dispose();
//   }

//   void setLastSong(String filePath) {
//     lastSong = filePath;
//   }

//   String getLastSong() {
//     return lastSong;
//   }

//   void setNowPlaying(bool value) {
//     nowPlaying = value;
//   }

//   bool getNowPlaying() {
//     return nowPlaying;
//   }
// }

import 'package:audioplayers/audioplayers.dart';

class Player {
  final source = AudioPlayer();
  String lastSong = '';
  bool sourceReady = false;
  bool nowPlaying = false;

  void play(String filePath) async {
    try {
      await source.setSource(DeviceFileSource(filePath));
      setLastSong(filePath);
      setNowPlaying(true);

      await source.resume();
      sourceReady = true;
    } catch (e) {
      print('Error playing audio: $e');
      // Handle the error accordingly (e.g., show an error message).
    }
  }

  void pause() async {
    try {
      await source.pause();
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  void resume() async {
    try {
      if (sourceReady == false) {
        play(getLastSong());
      }
      await source.resume();
    } catch (e) {
      print('Error resuming audio: $e');
    }
  }

  void dispose() async {
    try {
      await source.dispose();
    } catch (e) {
      print('Error disposing audio player: $e');
    }
  }

  void setLastSong(String filePath) {
    lastSong = filePath;
  }

  String getLastSong() {
    return lastSong;
  }

  void setNowPlaying(bool value) {
    nowPlaying = value;
  }

  bool getNowPlaying() {
    return nowPlaying;
  }
}
