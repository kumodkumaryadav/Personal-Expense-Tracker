import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/services/notification_services.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: scheduleNotification,
          child: const Text('Schedule Notification'),
        ),
      ),
    );
  }

  Future<void> scheduleNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final localLocation = tz.getLocation('Asia/Kolkata');
    var scheduledDateTime = DateTime.now().add(const Duration(seconds: 5));
    var tzScheduledDateTime = tz.TZDateTime(
      localLocation,
      scheduledDateTime.year,
      scheduledDateTime.month,
      scheduledDateTime.day,
      scheduledDateTime.hour,
      scheduledDateTime.minute,
      scheduledDateTime.second,
    );

    await _requestPermissionAndScheduleNotification(
        flutterLocalNotificationsPlugin, tzScheduledDateTime);
  }

  Future<void> _requestPermissionAndScheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      tz.TZDateTime tzScheduledDateTime) async {
    await Permission.scheduleExactAlarm.request();
    final status = await Permission.scheduleExactAlarm.status;
    print("status $status");

    if (status.isGranted) {
      // Proceed with scheduling notification using zonedSchedule
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "title",
        "This is a scheduled notification",
        tzScheduledDateTime,
        const NotificationDetails(
            android: AndroidNotificationDetails("0", "Schedule notification")),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else if (status.isDenied) {
      await _handlePermissionDenied();
    } else if (status.isRestricted) {
      await _handlePermissionRestricted();
    }
  }

  Future<void> _handlePermissionDenied() async {
    await Permission.notification.request();
    await Permission.scheduleExactAlarm.request();
    openAppSettings();

    final requestResult = await Permission.scheduleExactAlarm.request();
    if (requestResult == PermissionStatus.granted) {
      await scheduleNotification(); // Retry scheduling after permission granted
    } else {
      await Permission.scheduleExactAlarm.request();
      // Handle denial (show explanation or open app settings)
    }
  }

  Future<void> _handlePermissionRestricted() async {
    openAppSettings();
    // Handle restricted scenario
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

//  to listen to any notification clicked or not
  listenToNotifications() async {
    await LocalNotifications
        .init(); //must initialize before listening any stream
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      Get.offAllNamed(RouteName.addExpenseScreen);

      // print(event);
      // Navigator.pushNamed(context, '/another', arguments: event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Local Notifications")),
      body: Container(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.notifications_outlined),
                onPressed: () {
                  LocalNotifications.showSimpleNotification(
                      title: "Simple Notification",
                      body: "This is a simple notification",
                      payload: "This is simple data");
                },
                label: Text("Simple Notification"),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.timer_outlined),
                onPressed: () {
                  LocalNotifications.showPeriodicNotifications(
                      title: "Periodic Notification",
                      body: "This is a Periodic Notification",
                      payload: "This is periodic data");
                },
                label: Text("Periodic Notifications"),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.timer_outlined),
                onPressed: () {
                  LocalNotifications.showScheduleNotification(
                      title: "Did you add today's expenses",
                      body: "Tap to add today's expense",
                      payload: "This is schedule data",
                      dateTime: DateTime.now());
                },
                label: Text("Schedule Notifications"),
              ),
              // to close periodic notifications
              ElevatedButton.icon(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    LocalNotifications.cancel(1);
                  },
                  label: Text("Close Periodic Notifcations")),
              ElevatedButton.icon(
                  icon: Icon(Icons.delete_forever_outlined),
                  onPressed: () {
                    LocalNotifications.cancelAll();
                  },
                  label: Text("Cancel All Notifcations"))
            ],
          ),
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Another Page")),
      body: Center(child: Text(data.toString())),
    );
  }
}
