import 'package:flutter/material.dart';
import 'presenter.dart';

class AppView extends StatelessWidget {
  final AppPresenter presenter;

  AppView(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVP Example'),
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
