import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
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
                    icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    dateController.text = DateFormat.yMd().format(pickedDate);
                  }
                },
              ),
            )));
  }
}
