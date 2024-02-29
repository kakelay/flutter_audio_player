import 'package:flutter/material.dart';

class TabPart extends StatelessWidget {
  const TabPart({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Center(
        child: Text(
          "Tracks",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
  }
}
