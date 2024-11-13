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
  List<String> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    // Setting up the updateView callback to update displayed meals when filters are selected
    widget.mealFilterPresenter.updateView = (filteredMeals) {
      setState(() {
        displayedMeals = filteredMeals;
      });
    };
    // Initial call to show all meals by default
    widget.mealFilterPresenter.onFiltersSelected([]);
  }

  void _showFilterDialog() async {
    // Options for meal filters
    List<String> options = ['Vegan', 'Vegetarian', 'Non-Vegan'];

    // Show a dialog with filter options
    final selected = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelectedFilters = List.from(selectedFilters);
        return AlertDialog(
          title: const Text('Select Filters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return CheckboxListTile(
                title: Text(option),
                value: tempSelectedFilters.contains(option),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      tempSelectedFilters.add(option);
                    } else {
                      tempSelectedFilters.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close without changes
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, tempSelectedFilters), // Apply changes
              child: Text('Apply'),
            ),
          ],
        );
      },
    );

    // Update selected filters and apply them if a selection was made
    if (selected != null) {
      setState(() {
        selectedFilters = selected;
      });
      widget.mealFilterPresenter.onFiltersSelected(selectedFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Filter Feature'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog, // Show filter dialog on press
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(displayedMeals[index]),
          );
        },
      ),
    );
  }
}
