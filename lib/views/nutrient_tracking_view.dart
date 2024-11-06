import 'package:flutter/material.dart';
import '../presenters/nutrient_tracking_presenter.dart';

class NutrientTrackingView extends StatefulWidget {
  final NutrientTrackingPresenter presenter;

  NutrientTrackingView(this.presenter, {Key? key}) : super(key: key);

  @override
  _NutrientTrackingViewState createState() => _NutrientTrackingViewState();
}

class _NutrientTrackingViewState extends State<NutrientTrackingView> {
  final TextEditingController _queryController = TextEditingController();
  String data = ""; // To hold API response data

  @override
  void initState() {
    super.initState();

    // Set the updateView callback to update the data in the state
    widget.presenter.updateView = (String newData) {
      setState(() {
        data = newData;
      });
    };
  }

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
              onPressed: () => widget.presenter.loadData(_queryController.text),
              child: Text('Show Nutrient Summary'),
            ),
            SizedBox(height: 20),
            Text(
              data,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
