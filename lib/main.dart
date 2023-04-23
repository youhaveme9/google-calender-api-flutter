import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myapp/calender_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddEvent(),
    );
  }
}

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(days: 1));
  final TextEditingController eventName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Add Event to google Calender",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Choose Date and Time",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2019, 3, 5),
                              maxTime: DateTime(2200, 6, 7),
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              startTime = date;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: const Text(
                          'Event Start Time',
                          style: TextStyle(color: Colors.blue),
                        )),
                    Text('$startTime'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2019, 3, 5),
                              maxTime: DateTime(2200, 6, 7),
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              endTime = date;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: const Text(
                          'Event End Time',
                          style: TextStyle(color: Colors.blue),
                        )),
                    Text('$endTime'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: eventName,
                    decoration: const InputDecoration(
                        hintText: 'Enter Event name',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        CalenderClient client =
                            CalenderClient(startTime, endTime, eventName.text);
                        client.addToCalender(
                            startTime, endTime, eventName.text);
                      },
                      child: const Text("Add"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
