import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final settingsOpened = ref.watch(settingsState);
        return settingsOpened
            ? SingleChildScrollView(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 60),
                      segmentedSpeed(),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Center(
                    child: Text(
                      "Music",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 22,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void _saveDarkThemePreference(
      bool value, AsyncValue<SharedPreferences> pref) {
    if (pref is AsyncData<SharedPreferences>) {
      pref.value.setBool('darkMode', value);
    }
  }
}

final segmentedButtonProvider =
    StateProvider<ThemeType>((ref) => ThemeType.system);

enum ThemeType { light, system, dark }

segmentedSpeed() => Consumer(
      builder: (context, WidgetRef ref, __) {
        final selected = ref.watch(segmentedButtonProvider);
        return SegmentedButton(
          segments: [
            ButtonSegment(
                value: ThemeType.light,
                label: segmentedText('Light Theme'),
                icon: const Icon(Icons.light_mode)),
            ButtonSegment(
                value: ThemeType.system,
                label: segmentedText('System Default'),
                icon: const Icon(Icons.settings_suggest_rounded)),
            ButtonSegment(
                value: ThemeType.dark,
                label: segmentedText('Dark Theme'),
                icon: const Icon(Icons.dark_mode)),
          ],
          selected: {selected},
          onSelectionChanged: (newSelection) {
            newSelection.first == ThemeType.light
                ? AdaptiveTheme.of(context).setLight()
                : newSelection.first == ThemeType.dark
                    ? AdaptiveTheme.of(context).setDark()
                    : AdaptiveTheme.of(context).setSystem();

            ref.read(segmentedButtonProvider.notifier).state =
                newSelection.first;
          },
          style: ButtonStyle(
            visualDensity: VisualDensity.comfortable,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );

segmentedText(String text) => Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'Play',
      ),
    );
