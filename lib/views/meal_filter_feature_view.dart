import 'package:flutter/material.dart';
import '../presenters/meal_filter_feature_presenter.dart';

class MealFilterFeature extends StatefulWidget {
  final MealFilterPresenter mealFilterPresenter;

  MealFilterFeature({Key? key, required this.mealFilterPresenter}) : super(key: key);

  @override
  _MealFilterFeatureState createState() => _MealFilterFeatureState();
}

class _MealFilterFeatureState extends State<MealFilterFeature> {
  List<String> displayedMeals = [];

  @override
  void initState() {
    super.initState();
    widget.mealFilterPresenter.updateView = (meals) {
      setState(() {
        displayedMeals = meals;
      });
    };
    displayedMeals = widget.mealFilterPresenter.model.allMeals; // Initial load of meals
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['Vegan', 'Chicken', 'Vegetarian', 'Beef']; // Example filter options

    return Scaffold(
      appBar: AppBar(title: Text("Meal Filter")),
      body: Column(
        children: [
          // Filter checkboxes
          Wrap(
            spacing: 10.0,
            children: filters.map((filter) {
              return CheckboxListTile(
                title: Text(filter),
                value: widget.mealFilterPresenter.selectedFilters.contains(filter),
                onChanged: (isSelected) {
                  setState(() {
                    widget.mealFilterPresenter.toggleFilter(filter);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Display filtered meals
          Expanded(
            child: ListView.builder(
              itemCount: displayedMeals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(displayedMeals[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}