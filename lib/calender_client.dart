import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class CalenderClient {
  final DateTime startDate;
  final DateTime endDate;
  final String eventName;
  CalenderClient(this.startDate, this.endDate, this.eventName);

  Future<void> addToCalender(DateTime start, DateTime end, String name) async {
    Event event = Event(
      start: EventDateTime(date: start),
      end: EventDateTime(date: end),
      summary: name,
    );
    final googleSignIn = GoogleSignIn(
      scopes: <String>[CalendarApi.calendarScope],
    );
    await googleSignIn.signIn();
    final client = await googleSignIn.authenticatedClient();
    if (client != null) {
      CalendarApi calendar = CalendarApi(client);
      String calendarId = "primary";
      try {
        await calendar.events.insert(event, calendarId);
        debugPrint("Added to Calender");
      } catch (e) {
        debugPrint("Failed to add");
      }
    }
  }
}
