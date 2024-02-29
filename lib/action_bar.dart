import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/screen.dart';
import 'package:youtube/tracks_list.dart';

import 'main.dart';

icon(
  BuildContext context,
  void Function() onPressed,
  IconData icon,
) =>
    IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (_, WidgetRef ref, __) {
          final nowPlaying = ref.watch(playingStateProvider);
          {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: icon(
                        context,
                        () => previousSong(ref),
                        Icons.skip_previous_rounded,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                      child: icon(
                        context,
                        () {
                          if (nowPlaying) {
                            ref.read(playerProvider.notifier).state.pause();
                            ref.read(playingStateProvider.notifier).state =
                                false;
                          } else {
                            ref.read(playerProvider.notifier).state.resume();
                            ref.read(playingStateProvider.notifier).state =
                                true;
                          }
                        },
                        nowPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                      child: icon(
                        context,
                        () => nextSong(ref),
                        Icons.skip_next_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
}

void previousSong(WidgetRef ref) {
  final currentIndex = ref.read(playingIndex.notifier).state;
  final songs = ref.read(listFileEntityProvider.notifier).state;
  ref.read(playingStateProvider.notifier).state = true;

  //Nothing happens, the same song is played again
  if (currentIndex == 0) {
    const index = 0;
    ref.read(playingIndex.notifier).state = index;
    ref.read(playerProvider.notifier).state.play(songs[index].path);

    //Play the previous song
  } else {
    ref.read(playingIndex.notifier).state = currentIndex - 1;
    ref.read(playerProvider.notifier).state.play(songs[currentIndex - 1].path);
  }
}

void nextSong(WidgetRef ref) {
  final currentIndex = ref.read(playingIndex.notifier).state;
  final totalSongs = ref.read(totalSongsProvider.notifier).state;
  final songs = ref.read(listFileEntityProvider.notifier).state;
  ref.read(playingStateProvider.notifier).state = true;

  //If the song is the last one, play the first one
  if (currentIndex == totalSongs - 1) {
    const index = 0;
    ref.read(playingIndex.notifier).state = index;
    ref.read(playerProvider.notifier).state.play(songs[index].path);

    //Play the next song
  } else {
    ref.read(playingIndex.notifier).state = currentIndex + 1;
    ref.read(playerProvider.notifier).state.play(songs[currentIndex + 1].path);
  }
}
