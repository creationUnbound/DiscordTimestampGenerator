import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './date_time_picker.dart';

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
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    DateTimePicker dateTimePicker = DateTimePicker(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Discord Timestamp Generator"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
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
                  }
                  /*() async {
                  DateTime? pickedDate = await dateTimePicker.pickDate();
                  //await Future.delayed(const Duration(milliseconds: 200));
                  if (mounted && pickedDate != null) {
                    TimeOfDay? pickedTime = await dateTimePicker.pickTime();
                    if (pickedTime != null) {
                      // This is where a function for translating
                      // pickedDate and pickedTime to Unix time would be.
                      // DateTime dateTime =
                      dateController.text = DateFormat.yMd().format(pickedDate);
                    }
                  }
                },*/
                  ),
            )));
  }
}
