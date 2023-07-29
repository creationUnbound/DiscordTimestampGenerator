import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimestampDisplay extends StatefulWidget {
  final DiscordUnixstamp discordUnixstamp;
  final VoidCallback onPressedExtension;

  const TimestampDisplay(
      {super.key,
      required this.discordUnixstamp,
      required this.onPressedExtension});

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
    var clipboardNotifier = context.watch<ClipboardNotifier>();

    return ListenableBuilder(
        listenable: widget.discordUnixstamp,
        builder: (BuildContext context, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 12,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 7, bottom: 0, right: 0, top: 0),
                  child: Text(DateFormat(widget.discordUnixstamp.style.format)
                      .format(widget.discordUnixstamp.dateTime)),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 155,
                    child: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                            // Copies timestamp to clipboard
                            ClipboardData(
                                text: widget.discordUnixstamp.toString()));
                        await clipboardNotifier.updateTextFromClipboard();
                      },
                      child: Card(
                          color: theme.colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                                alignment: Alignment.center,
                                child:
                                    Text(widget.discordUnixstamp.toString())),
                          )),
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        // Need a way to encapsulate this in a function so it can be called from multiple parts of this file
                        await Clipboard.setData(
                            // Copies timestamp to clipboard
                            ClipboardData(
                                text: widget.discordUnixstamp.toString()));
                        await clipboardNotifier.updateTextFromClipboard();
                      },
                      icon: Icon((clipboardNotifier.text ==
                              widget.discordUnixstamp.toString())
                          ? Icons.check
                          : Icons.copy),
                      label: Text((clipboardNotifier.text ==
                              widget.discordUnixstamp.toString())
                          ? "Copied!"
                          : "Copy Text"))
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        });
  }
}
