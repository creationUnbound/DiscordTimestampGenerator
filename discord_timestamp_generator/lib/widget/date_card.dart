import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onPressed;
  const DateCard({super.key, required this.dateTime, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
        color: theme.colorScheme.surfaceVariant,
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Test"),
        ));
  }
}
