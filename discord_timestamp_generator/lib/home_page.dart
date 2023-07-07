import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'utility/date_time_picker.dart';
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
    //For resizing GridView properly
    //var size = MediaQuery.of(context).size;
    //final double itemHeight = size.height / 10;
    //final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Discord Timestamp Generator"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: ListView(
            padding: const EdgeInsets.all(10),
            //scrollDirection: Axis.vertical,
            children: [
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
                    // Do something with the dateTime attributes here
                  }),
              // TODO: Currently working on making DateCard functional
              TimestampDisplay(
                dateTime: dateTimePicker.dateTime,
                onPressed: () {},
              ),
              TimestampDisplay(
                dateTime: dateTimePicker.dateTime,
                onPressed: () {},
              ),
            ]));
  }
}
