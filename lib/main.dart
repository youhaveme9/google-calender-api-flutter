import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Event> allEvents = [
    Event(
      summary: "Meeting123",
      description: "Hello",
      start: EventDateTime(date: DateTime.utc(2023, 4, 12)),
      end: EventDateTime(date: DateTime.utc(2023, 4, 12)),
    ),
    Event(
      summary: "Meeting123",
      description: "Hello",
      start: EventDateTime(date: DateTime.utc(2023, 4, 13)),
      end: EventDateTime(date: DateTime.utc(2023, 4, 13)),
    ),
    Event(
      summary: "Meeting123",
      description: "Hello",
      start: EventDateTime(date: DateTime.utc(2023, 4, 14)),
      end: EventDateTime(date: DateTime.utc(2023, 4, 14)),
    ),
  ];
  Future addDateTime(List lst) async {
    final googleSignIn = GoogleSignIn(
      scopes: <String>[CalendarApi.calendarScope],
    );
    await googleSignIn.signIn();
    final client = await googleSignIn.authenticatedClient();

    var calendar = CalendarApi(client!);

    String calendarId = "primary";
    // Event event = Event(
    //   summary: "Meeting123",
    //   description: "Hello",
    //   start: EventDateTime(date: DateTime.utc(2023, 4, 25)),
    //   end: EventDateTime(date: DateTime.utc(2023, 4, 25)),
    // );

    print("Hello");
    for (int i = 0; i < lst.length; i++) {
      await calendar.events
          .insert(lst[i], calendarId)
          .then((value) => print(value.status));
    }
    // lst.map((event) {
    //   // calendar.events
    //   //     .insert(event, calendarId)
    //   //     .then((value) => print(value.status));
    //   print("Hello");
    //   print(event);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add Data to calender"),
            ElevatedButton(
              onPressed: () async {
                await addDateTime(allEvents);
                debugPrint("Data added");
              },
              child: const Text("Add to calender"),
            ),
          ],
        ),
      ),
    );
  }
}
