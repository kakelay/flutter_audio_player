import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube/themes/app_colors/app_color.dart';

import 'main.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final settingsOpened = ref.watch(settingsState);
        return settingsOpened
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    const Gap(20),
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(20),
                    segmentedSpeed(),
                  ],
                ),
              )
            : AnimatedContainer(
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
