 
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:youtube/screen.dart';
import 'package:youtube/theme_data.dart';

class AdaptiveRoot extends StatefulWidget {
  const AdaptiveRoot({
    required this.appTitle,
    this.savedThemeMode,
    super.key,
    this.debugShowFloatingThemeButton = false,
  });

  final String appTitle;
  final AdaptiveThemeMode? savedThemeMode;
  final bool debugShowFloatingThemeButton;

  @override
  State<AdaptiveRoot> createState() => _AdaptiveRootState();
}

class _AdaptiveRootState extends State<AdaptiveRoot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => rootConfig(
        context,
        widget.savedThemeMode,
        widget.appTitle,
        widget.debugShowFloatingThemeButton,
      );
}

Widget rootConfig(
  BuildContext context,
  AdaptiveThemeMode? savedThemeMode,
  String appTitle,
  bool debugShowFloatingThemeButton,
) =>
    AdaptiveTheme(
      light: MaterialThemeData().light(),
      dark: MaterialThemeData().dark(),
      debugShowFloatingThemeButton: debugShowFloatingThemeButton,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
          onGenerateTitle: (context) => appTitle,
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: theme.colorScheme.background,
                child: Screen()),
          )),
    );
