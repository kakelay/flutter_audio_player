// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youtube/top_bar.dart';
import 'main.dart';
import 'tab_part.dart';
import 'tracks_list.dart';
import 'player.dart';
import 'action_bar.dart';

//Player Provider
final playerProvider = StateProvider<Player>((ref) {
  return Player();
});

class Screen extends ConsumerStatefulWidget {
  const Screen({super.key});

  @override
  ConsumerState<Screen> createState() => _NewState();
}

class _NewState extends ConsumerState<Screen> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) =>
      Consumer(builder: (_, WidgetRef ref, __) {
        final settingsOpened = ref.watch(settingsState);
        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            constraints: const BoxConstraints(maxWidth: 460),
            padding: settingsOpened
                ? const EdgeInsets.fromLTRB(0, 30, 0, 0)
                : const EdgeInsets.fromLTRB(10, 30, 10, 10),
            // ignore: deprecated_member_use
            child: WillPopScope(
              onWillPop: () async {
                ref.read(settingsState.notifier).state = false;
                if (settingsOpened) {
                  return false; // Prevent the back navigation
                } else {
                  return true; // Allow the back navigation
                }
              },
              child: column(context, ref, settingsOpened),
            ),
          ),
        );
      });

  void requestPermissions() async {
    if (UniversalPlatform.isWeb) {
      return;
    } else if (await Permission.storage.request().isGranted) {
      print("TRUE = await Permission.storage.request().isGranted");
    } else {
      print("FALSE = await Permission.storage.request().isGranted");
    }
  }

  column(
    BuildContext context,
    WidgetRef ref,
    bool settingsOpened,
  ) =>
      Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                ref.read(settingsState.notifier).state =
                    !ref.watch(settingsState);
                print(ref.watch(settingsState));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: settingsOpened
                    ? MediaQuery.of(context).size.height - 30
                    : 110,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: settingsOpened
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )
                      : const BorderRadius.all(Radius.circular(35)),
                ),
                child: const TopBar(),
              ),
            ),
          ),
          SizedBox(height: settingsOpened ? 0 : 12),
          AnimatedContainer(
            height:
                settingsOpened ? 0 : MediaQuery.of(context).size.height - 162,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(35)),
            ),
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            child: column2(),
          ),
        ],
      );

  column2() => Column(
        children: [
          Expanded(
            child: container(context),
          ),
          AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 300),
            height: 50,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: const ActionBar(),
          )
        ],
      );

  container(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(33),
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            const TabPart(),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const TracksList(),
              ),
            ),
          ],
        ),
      );
}
