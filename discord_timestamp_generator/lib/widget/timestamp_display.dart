import 'package:flutter/material.dart';

class TimestampDisplay extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onPressed;
  const TimestampDisplay(
      {super.key, required this.dateTime, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    /*
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    */

    return Row(
      children: [
        Card(
            color: theme.colorScheme.surfaceVariant,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Timestamp"),
            )),
        Card(
            color: theme.colorScheme.surfaceVariant,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Copy text"),
            )),
      ],
    );
  }
}
