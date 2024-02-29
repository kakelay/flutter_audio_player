import 'package:audioplayers/audioplayers.dart';

class Player {
  final source = AudioPlayer();
  String lastSong = '';
  bool sourceReady = false;
  bool nowPlaying = false;

  void play(String filePath) async {
    await source.setSource(DeviceFileSource(filePath));
    setLastSong(filePath);
    setNowPlaying(true);

    await source.resume();
    sourceReady = true;
  }

  //Δημιούργησε μια μέθοδο όπου δεν θα δέχεται τίποτα και θα κάνει await source.pause();
  void pause() async {
    await source.pause();
  }

  void resume() async {
    if (sourceReady == false) {
      play(getLastSong());
    }
    await source.resume();
  }

  void dispose() async {
    await source.dispose();
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
