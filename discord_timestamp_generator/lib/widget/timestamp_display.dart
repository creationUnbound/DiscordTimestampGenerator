import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:discord_timestamp_generator/utility/media_aware_size.dart';
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
    const double expandLimit = 930;

    return ListenableBuilder(
        listenable: widget.discordUnixstamp,
        builder: (BuildContext context, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: MediaAwareSize(context, expandLimit, .015, 14)
                      .widthBasedSize,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 7, bottom: 2, right: 0, top: 4),
                  child: Text(DateFormat(widget.discordUnixstamp.style.format)
                      .format(widget.discordUnixstamp.dateTime)),
                ),
              ),
              Wrap(
                children: [
                  SizedBox(
                    width: MediaAwareSize(context, expandLimit, .169, 155)
                        .widthBasedSize,
                    height: MediaAwareSize(context, expandLimit, .055, 50)
                        .widthBasedSize,
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
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 6, right: 10, top: 6),
                            child: Align(
                                alignment: Alignment.center,
                                child: DefaultTextStyle.merge(
                                    style: TextStyle(
                                        fontSize: MediaAwareSize(
                                                context, expandLimit, .015, 14)
                                            .widthBasedSize),
                                    child: Text(
                                        widget.discordUnixstamp.toString()))),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2, bottom: 6, right: 10, top: 4),
                    child: ElevatedButton.icon(
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
                            : "Copy Text")),
                  )
                ],
              ),
            ],
          );
        });
  }
}
