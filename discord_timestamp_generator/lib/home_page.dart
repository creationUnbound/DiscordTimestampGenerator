import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp.dart';
import 'package:discord_timestamp_generator/utility/timestamp_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    //var timestampNotifier = context.watch<TimestampNotifier>();

    //List of TimestampDisplay widgets
    List<TimestampDisplay> timestampDisplays = [];
    for (var style in DiscordUnixstampStyle.values) {
      timestampDisplays.add(
        TimestampDisplay(
          discordUnixstamp: DiscordUnixstamp(style, dateTimePicker.dateTime),
          // TODO: Implement this
          onPressed: () {},
        ),
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
                    // TODO: Tell the TimestampDisplays that they can update their dateTime
                  }),
            ]),
            Column(children: timestampDisplays),
          ],
        ));
  }
}
