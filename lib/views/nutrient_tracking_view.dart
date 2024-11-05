import 'package:flutter/material.dart';
import '../presenters/nutrient_tracking_presenter.dart';

class NutrientTrackingView extends StatelessWidget {
  final NutrientTrackingPresenter presenter;
  final String data;

  NutrientTrackingView(this.presenter, {required this.data});

  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrient Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _queryController,
              decoration: InputDecoration(hintText: 'Enter food items'),
            ),
            ElevatedButton(
              onPressed: () => presenter.loadData(_queryController.text), 
              child: Text('Showing Nutrient Summary'),
              ),
              SizedBox(height: 20), 
              Text(data, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
