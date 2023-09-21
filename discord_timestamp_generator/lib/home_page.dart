import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:discord_timestamp_generator/utility/media_aware_size.dart';
import 'package:discord_timestamp_generator/utility/theme_notifier.dart';
import 'package:discord_timestamp_generator/widget/subtle_notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'utility/date_time_picker.dart';
import 'utility/discord_unixstamp/discord_unixstamp_style.dart';
import 'widget/timestamp_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClipboardNotifier clipboardComparator = ClipboardNotifier();
  late ThemeNotifier themeNotifier;
  TextEditingController dateController = TextEditingController();
  List<TimestampDisplay> timestampDisplays = [];
  List<SubtleNotification> subtleNotifications = [];
  late DateTimePicker dateTimePicker;

  @override
  void initState() {
    super.initState();
    dateTimePicker = DateTimePicker(context);
    dateController.text =
        DateFormat.yMd().add_jm().format(dateTimePicker.dateTime);

    //List of TimestampDisplay widgets
    for (var style in DiscordUnixstampStyle.values) {    
      timestampDisplays.add(
        TimestampDisplay(
          discordUnixstamp: DiscordUnixstamp(style, dateTimePicker.dateTime),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    themeNotifier = context.watch<ThemeNotifier>();

    return Scaffold(
          appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.discord, size: 50),
            ),
            title: const Text("Discord Timestamp Generator"),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        child: AnimatedPadding(
                          padding: EdgeInsets.only(
                              left: MediaAwareSize(context, 350, .05, 0)
                                  .widthBasedSize,
                              right: MediaAwareSize(context, 350, .04, 10)
                                  .widthBasedSize,
                              bottom: 15),
                          duration: const Duration(milliseconds: 250),
                          child: TextField(
                              controller: dateController,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "Enter Date"),
                              readOnly: true,
                              onTap: () async {
                                await dateTimePicker.pickDateTime();
                                dateController.text = DateFormat.yMd()
                                    .add_jm()
                                    .format(dateTimePicker.dateTime);
                                // Tells the TimestampDisplays that they can update their dateTime.
                                for (var timestampDisplay
                                    in timestampDisplays) {
                                  timestampDisplay.discordUnixstamp
                                      .update(dateTimePicker.dateTime);
                                }
                              }),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                            onPressed: () {
                              themeNotifier.switchTheme();
                            },
                            icon: Icon(!themeNotifier.isDark
                                ? Icons.nightlight
                                : Icons.sunny))),
                  )
                ],
              ),
              ChangeNotifierProvider.value(
                  value: clipboardComparator,
                  child: Center(child: Wrap(children: timestampDisplays))),
            ],
          ));
  }
}
