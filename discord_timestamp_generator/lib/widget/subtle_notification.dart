import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubtleNotification extends StatefulWidget {
  const SubtleNotification({super.key});

  @override
  State<SubtleNotification> createState() => _SubtleNotificationState();
}

class _SubtleNotificationState extends State<SubtleNotification> {
  late ChangeNotifier notifier;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool _visible = true;
    notifier = context.watch<ClipboardNotifier>();

    return AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
            width: 155,
            height: 50,
            child: Card(color: theme.colorScheme.primaryContainer)));
  }
}
