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
    _visible = true;

    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        _visible = false;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    notifier = context.watch<ClipboardNotifier>();

    return AnimatedOpacity(
        opacity: _visible? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
            width: 210,
            height: 50,
            child: Card(color: theme.colorScheme.primaryContainer, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("Copied ${notifier.text}!")),
            ),)));
  }
}
