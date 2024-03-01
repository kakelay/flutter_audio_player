import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
