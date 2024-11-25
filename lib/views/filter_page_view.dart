// filter_page.dart
import 'package:flutter/material.dart';
import '../presenters/feature_food_list_presenter.dart';

class FilterPage extends StatefulWidget {
  final FeatureFoodListPresenter presenter;

  FilterPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    final filters = ['Vegan', 'Chicken', 'Vegetarian', 'Beef', 'Fish', 'Fruit']; // Example filters

    return Scaffold(
      appBar: AppBar(title: Text("Select Filters")),
      body: Column(
        children: filters.map((filter) {
          return CheckboxListTile(
            title: Text(filter),
            value: widget.presenter.selectedFilters.contains(filter),
            onChanged: (isSelected) {
              setState(() {
                widget.presenter.toggleFilter(filter);
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.of(context).pop(); // Return to the FoodListPage
        },
      ),
    );
  }
}
