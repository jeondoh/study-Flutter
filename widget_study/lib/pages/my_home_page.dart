import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_study/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                _showToast();
              },
              child: const Text('btn')),
          const Center(child: Text('hi')),
          ElevatedButton(
              onPressed: () async {
                final notification = flutterLocalNotificationsPlugin;
                const android = AndroidNotificationDetails(
                  '0',
                  '알림 테스트',
                  channelDescription: '알림 테스트 바디 부분',
                  importance: Importance.max,
                  priority: Priority.max,
                );
                const ios = IOSNotificationDetails();
                const detail = NotificationDetails(
                  android: android,
                  iOS: ios,
                );

                final permission = Platform.isAndroid
                    ? true
                    : await notification
                            .resolvePlatformSpecificImplementation<
                                IOSFlutterLocalNotificationsPlugin>()
                            ?.requestPermissions(
                                alert: true, badge: true, sound: true) ??
                        false;

                if(!permission){
                  return;
                }

                await flutterLocalNotificationsPlugin.show(
                  0,
                  'plain title',
                  'plain body',
                  detail,
                );
              },
              child: const Text('add Alarms')),
          const Center(child: Text('hi'))
        ],
      ),
    );
  }

  void _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: 16.0,
            left: 16.0,
            child: child,
          );
        });
  }
}
