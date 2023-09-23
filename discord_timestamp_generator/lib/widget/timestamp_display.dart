import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:discord_timestamp_generator/widget/subtle_notification.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimestampDisplay extends StatefulWidget {
  final DiscordUnixstamp discordUnixstamp;

  const TimestampDisplay({super.key, required this.discordUnixstamp});

  @override
  State<TimestampDisplay> createState() => _TimestampDisplayState();
}

class _TimestampDisplayState extends State<TimestampDisplay> {
  late ClipboardNotifier clipboardNotifier;

  @override
  void initState() {
    super.initState();
  }

  void _copyToClipboard() async {
    await Clipboard.setData(
        // Copies timestamp to clipboard
        ClipboardData(text: widget.discordUnixstamp.toString()));
    await clipboardNotifier.updateTextFromClipboard();
  }

  void _clipboardSuccess(ClipboardNotifier clipboardNotifier) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    bool moving = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      moving = true;
    });

    overlayEntry = OverlayEntry(builder: (context) {
      return AnimatedPositioned(
          left: (MediaQuery.of(context).size.width / 2) - 105,
          bottom: moving ? 200 : 30,
          duration: const Duration(seconds: 2),
          child: ChangeNotifierProvider.value(
              value: clipboardNotifier, child: const SubtleNotification()));
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayEntry);

    // Awaiting for 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Removing the OverlayEntry from the Overlay
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    clipboardNotifier = context.watch<ClipboardNotifier>();

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
                    width: 155,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        _copyToClipboard();
                        _clipboardSuccess(clipboardNotifier);
                      },
                      child: Card(
                          color: theme.colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 6, right: 10, top: 6),
                            child: Center(
                                child: DefaultTextStyle.merge(
                                    style: const TextStyle(fontSize: 14),
                                    child: Text(
                                        widget.discordUnixstamp.toString()))),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2, bottom: 6, right: 10, top: 4),
                    child: SizedBox(
                      width: 138,
                      height: 43,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  theme.colorScheme.onPrimaryContainer,
                              backgroundColor:
                                  theme.colorScheme.primaryContainer),
                          onPressed: () async {
                            _copyToClipboard();
                            _clipboardSuccess(clipboardNotifier);  
                          },
                          icon: Icon((clipboardNotifier.text ==
                                  widget.discordUnixstamp.toString())
                              ? Icons.check
                              : Icons.copy),
                          label: DefaultTextStyle.merge(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            child: Text((clipboardNotifier.text ==
                                    widget.discordUnixstamp.toString())
                                ? "Copied!"
                                : "Copy Text"),
                          )),
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
