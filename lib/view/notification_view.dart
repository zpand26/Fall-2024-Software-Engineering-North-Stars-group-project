import 'package:flutter/material.dart';
import '../presenter/notification_presenter.dart';
import '../notification/home.dart';

class AppView extends StatelessWidget {
  final AppPresenter presenter;

  AppView(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVP Example'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              if (choice == 'Notifications') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
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
      body: Center(
        child: ElevatedButton(
          onPressed: () => presenter.loadData(),
          child: Text('Load Data'),
        ),
      ),
    );
  }
}
