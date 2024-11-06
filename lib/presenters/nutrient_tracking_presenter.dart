import 'dart:collection';

import 'package:north_stars/views/home_page_view.dart';

import '../models/nutrient_tracking_model.dart';

class NutrientTrackingPresenter  {
  final NutrientTrackerModel nutrientTrackerModel;
  Function(String) updateView;

  NutrientTrackingPresenter(this.nutrientTrackerModel, this.updateView);

  //data fetching from API
  void loadData(String query) async{
    String data = await nutrientTrackerModel.fetchData(query);
    updateView(data);
  }
}