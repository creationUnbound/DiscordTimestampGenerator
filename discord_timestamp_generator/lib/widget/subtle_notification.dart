import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubtleNotification extends StatefulWidget {
  const SubtleNotification({super.key});

  @override
  State<SubtleNotification> createState() => _SubtleNotificationState();
}

class _SubtleNotificationState extends State<SubtleNotification> {
  late ClipboardNotifier notifier;
  late bool _visible;

  @override
  void initState() {
    super.initState();
    _visible = false;
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    notifier = context.watch<ClipboardNotifier>();
    _visible = !_visible;

    double opacityController() {
      if (_visible) {
        return 1.0;
      } else {
        return 0.0;
      }
    }

    return AnimatedOpacity(
        opacity: opacityController(),
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
            width: 155,
            height: 50,
            child: Card(color: theme.colorScheme.primaryContainer, child: Text("Copied ${notifier.text}!"),)));
  }
}
