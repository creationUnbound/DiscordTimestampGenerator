import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:flutter/material.dart';

class TimestampDisplay extends StatefulWidget {
  final DiscordUnixstamp discordUnixstamp;
  final VoidCallback onPressed;

  const TimestampDisplay(
      {super.key, required this.discordUnixstamp, required this.onPressed});

  @override
  State<TimestampDisplay> createState() => _TimestampDisplayState();
}

class _TimestampDisplayState extends State<TimestampDisplay> {
  late DiscordUnixstamp _discordUnixstamp;

  @override
  void initState() {
    super.initState();
    _discordUnixstamp = widget.discordUnixstamp;
  }

  void updateDiscordUnixstamp(DateTime dateTime) {
    setState(() {
      _discordUnixstamp.update(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(
            fontSize: 14,
          ),
          child: Text(_discordUnixstamp.style.label),
        ),
        Row(
          children: [
            Card(
                color: theme.colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(_discordUnixstamp.toString()),
                )),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.copy),
              label: const Text('Copy text'),
            ),
          ],
        ),
      ],
    );
  }
}
