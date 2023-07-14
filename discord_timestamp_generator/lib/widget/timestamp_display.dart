import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimestampDisplay extends StatefulWidget {
  final DiscordUnixstamp discordUnixstamp;
  final VoidCallback onPressed;

  const TimestampDisplay(
      {super.key, required this.discordUnixstamp, required this.onPressed});

  @override
  State<TimestampDisplay> createState() => _TimestampDisplayState();
}

class _TimestampDisplayState extends State<TimestampDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
        listenable: widget.discordUnixstamp,
        builder: (BuildContext context, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 14,
                ),
                child: Text(widget.discordUnixstamp.style.label),
              ),
              Row(
                children: [
                  Card(
                      color: theme.colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.discordUnixstamp.toString()),
                      )),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                          // Copies timestamp to clipboard
                          ClipboardData(
                              text: widget.discordUnixstamp.toString()));
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy text'),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
