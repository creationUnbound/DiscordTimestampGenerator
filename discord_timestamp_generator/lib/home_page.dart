import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:discord_timestamp_generator/utility/media_aware_size.dart';
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
  TextEditingController dateController = TextEditingController();
  List<TimestampDisplay> timestampDisplays = [];
  late DateTimePicker dateTimePicker;

  @override
  void initState() {
    dateTimePicker = DateTimePicker(context);
    dateController.text =
        DateFormat.yMd().add_jm().format(dateTimePicker.dateTime);
    super.initState();

    //List of TimestampDisplay widgets
    for (var style in DiscordUnixstampStyle.values) {
      DiscordUnixstamp discordUnixstamp =
          DiscordUnixstamp(style, dateTimePicker.dateTime);
      timestampDisplays.add(
        TimestampDisplay(
          discordUnixstamp: discordUnixstamp,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //DateTimePicker dateTimePicker = DateTimePicker(context);
    //ClipboardNotifier clipboardComparator = ClipboardNotifier();

    //List of TimestampDisplay widgets
    /*
    List<TimestampDisplay> timestampDisplays = [];
    for (var style in DiscordUnixstampStyle.values) {
      DiscordUnixstamp discordUnixstamp =
          DiscordUnixstamp(style, dateTimePicker.dateTime);
      timestampDisplays.add(
        TimestampDisplay(
          discordUnixstamp: discordUnixstamp,
        ),
      );
    }
    */

    return Scaffold(
        appBar: AppBar(
          title: const Text("Discord Timestamp Generator"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(children: [
              AnimatedPadding(
                padding: EdgeInsets.only(
                    left: MediaAwareSize(context, 350, .05, 0).widthBasedSize,
                    top: 0,
                    right: MediaAwareSize(context, 350, .05, 0).widthBasedSize,
                    bottom: 0),
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
                      for (var timestampDisplay in timestampDisplays) {
                        timestampDisplay.discordUnixstamp
                            .update(dateTimePicker.dateTime);
                      }
                    }),
              ),
              const SizedBox(height: 10),
            ]),
            Center(
              child: ChangeNotifierProvider.value(
                  value: clipboardComparator,
                  child: Wrap(children: timestampDisplays)),
            ),
          ],
        ));
  }
}
