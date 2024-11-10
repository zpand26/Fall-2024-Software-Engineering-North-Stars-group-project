import 'package:flutter/material.dart';
import 'notification_home.dart';
//This notification view is not being used at the moment refer to notification_home view
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              if (choice == 'Notifications') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationHome()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Notifications'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Notification Menu'),
      ),
    );
  }
}
