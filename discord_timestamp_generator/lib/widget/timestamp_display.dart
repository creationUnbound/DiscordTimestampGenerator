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

class _TimestampDisplayState extends State<TimestampDisplay>
    with TickerProviderStateMixin {
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

  void _clipboardSuccess() async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    AnimationController? controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1.5),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          left: (MediaQuery.of(context).size.width / 2) - 105,
          bottom: 30,
          child: SlideTransition(
              position: offsetAnimation,
              child: SubtleNotification(
                  text: "Copied ${widget.discordUnixstamp}")));
    });

    controller.addListener(() {
      overlayState.setState(() {});
    });
    // Starting the animation
    controller.forward();

    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2));

    overlayEntry.remove();
    controller.dispose();

    //TODO: AnimationController seems to stop working prematurely
    //Possible memory leaK
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
                        _clipboardSuccess();
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
                            _clipboardSuccess();
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
