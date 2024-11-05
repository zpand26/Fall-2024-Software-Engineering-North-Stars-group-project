import 'dart:collection';

import '../models/nutrient_tracking_model.dart';

class NutrientTrackingPresenter {
  final NutrientTrackerModel model;
  final Function(String) updateView;

  NutrientTrackingPresenter(this.model, this.updateView);

  //data fetching
  void loadData(String query) async{
    String data = await model.fetchData(query);
    updateView(data);
  }
}