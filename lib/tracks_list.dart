import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube/screen.dart';
import 'main.dart';

class TracksList extends StatelessWidget {
  const TracksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final audioFilesAsync = ref.watch(audioFilesProvider);
        final myPlayer = ref.watch(playerProvider);
        return audioFilesAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (audioFiles) {
            return ListView.builder(
              itemCount: audioFiles.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  myPlayer.setLastSong(audioFiles[index].path);
                }
                return trackTile(
                  audioFiles,
                  index,
                  Row(
                    children: [
                      musicIcon(context),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                removeExtension(
                                    audioFiles[index].uri.pathSegments.last),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              UniversalPlatform.isWeb
                                  ? textList(context)[index]
                                  : const Text(
                                      "Unknown",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget trackTile(
    List<FileSystemEntity> audioFiles,
    int index,
    Widget child,
  ) =>
      Consumer(
        builder: (context, ref, _) {
          final myPlayer = ref.watch(playerProvider);
          final currentIndex = ref.watch(playingIndex);

          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27),
                      ),
                    ),
                    color: currentIndex == index
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        myPlayer.play(audioFiles[index].path);
                        ref.read(playingIndex.notifier).state = index;
                        ref.read(playingStateProvider.notifier).state = true;
                      },
                      child: child,
                    ),
                  ),
                ),
                const SizedBox(height: 6)
              ],
            ),
          );
        },
      );

  Widget musicIcon(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: const EdgeInsets.all(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 85, 145).withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.music_note_rounded,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String removeExtension(String str) {
    return str.substring(0, str.length - 4);
  }
}

final playingIndex = StateProvider<int>((ref) => -1);
final totalSongsProvider = StateProvider<int>((ref) => 5);

//list of text
List<Row> textList(BuildContext context) => [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          linkText(
            context,
            "Alisia",
            Uri.parse(
                "https://pixabay.com/users/alisiabeats-39461785/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=170190"),
          ),
          simpleText(context, " | "),
          linkText(
            context,
            "Pixabay",
            Uri.parse(
                "https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=170190"),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          linkText(
            context,
            "Yrii Semchyshyn",
            Uri.parse(
                "https://pixabay.com/users/coma-media-24399569/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=168156"),
          ),
          simpleText(context, " | "),
          linkText(
            context,
            "Pixabay",
            Uri.parse(
                "https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=168156"),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          linkText(
            context,
            "Bohdan Kuzmin",
            Uri.parse(
              "https://pixabay.com/users/bodleasons-28047609/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=159456",
            ),
          ),
          simpleText(context, " | "),
          linkText(
            context,
            "Pixabay",
            Uri.parse(
              "https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=159456",
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          linkText(
            context,
            "Luis Humanoide",
            Uri.parse(
              "https://pixabay.com/users/humanoide_media-12661853/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=165111",
            ),
          ),
          simpleText(context, " | "),
          linkText(
            context,
            "Pixabay",
            Uri.parse(
              "https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=165111",
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          linkText(
            context,
            "Yevhen Onoychenko",
            Uri.parse(
              "https://pixabay.com/users/onoychenkomusic-24430395/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=136824",
            ),
          ),
          simpleText(context, " | "),
          linkText(
            context,
            "Pixabay",
            Uri.parse(
              "https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=136824",
            ),
          ),
        ],
      ),
    ];

linkText(
  BuildContext context,
  String text,
  Uri uri,
) =>
    TextButton(
      onPressed: () async {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch $uri';
        }
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        //Remove the minimum size of the button
        minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: "Roboto",
          color: Color.fromARGB(255, 70, 102, 170),
        ),
      ),
    );

simpleText(BuildContext context, String text) => Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: "Roboto",
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
