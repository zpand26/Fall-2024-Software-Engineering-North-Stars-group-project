import 'dart:collection';

import 'nutrient_tracking_model.dart';

class AppPresenter {
  final AppModel model;
  final Function(String) updateView;

  AppPresenter(this.model, this.updateView);

  //data fetching
  void loadData(String query) async{
    String data = await model.fetchData(query);
    updateView(data);
  }
}