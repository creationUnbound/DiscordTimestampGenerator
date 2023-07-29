import 'package:discord_timestamp_generator/utility/clipboard_notifier.dart';
import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
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
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTimePicker dateTimePicker = DateTimePicker(context);
    dateController.text =
        DateFormat.yMd().add_jm().format(dateTimePicker.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    DateTimePicker dateTimePicker = DateTimePicker(context);
    ClipboardNotifier clipboardComparator = ClipboardNotifier();

    //List of TimestampDisplay widgets
    List<TimestampDisplay> timestampDisplays = [];
    for (var style in DiscordUnixstampStyle.values) {
      DiscordUnixstamp discordUnixstamp =
          DiscordUnixstamp(style, dateTimePicker.dateTime);
      timestampDisplays.add(
        TimestampDisplay(
            discordUnixstamp: discordUnixstamp,
            onPressedExtension: () async {
              /*
              booleanTextNotifier.setText(await ClipboardComparator.isEqual(
                  discordUnixstamp.toString()));
                  */
            }),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Discord Timestamp Generator"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(children: [
              TextField(
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
              const SizedBox(height: 10),
            ]),
            ChangeNotifierProvider.value(
                value: clipboardComparator,
                child: Column(children: timestampDisplays)),
          ],
        ));
  }
}
