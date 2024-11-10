import 'package:flutter/material.dart';

class MealFilterFeature extends StatefulWidget {
  const MealFilterFeature({super.key});

  @override
  _MealFilterFeatureState createState() => _MealFilterFeatureState();
}
//
class _MealFilterFeatureState extends State<MealFilterFeature> {
  List<String> allMeals = ['Vegan Salad', 'Chicken Wrap', 'Vegetarian Pizza', 'Beef Steak'];
  List<String> filteredMeals = [];
  List<String> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    filteredMeals = List.from(allMeals); // Start by showing all meals
  }

  void applyFilters() {
    setState(() {
      if (selectedFilters.isEmpty) {
        filteredMeals = List.from(allMeals);
      } else {
        filteredMeals = allMeals.where((meal) {
          // Show meals that match the selected filters
          return selectedFilters.any((filter) => meal.toLowerCase().contains(filter.toLowerCase()));
        }).toList();
      }
    });
  }

  void showFilterDialog() async {
    List<String> options = ['Vegan', 'Vegetarian', 'Non-Vegan'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Filters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return CheckboxListTile(
                title: Text(option),
                value: selectedFilters.contains(option),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedFilters.add(option);
                    } else {
                      selectedFilters.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                applyFilters();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Filter Feature'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: showFilterDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredMeals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredMeals[index]),
          );
        },
      ),
    );
  }
}
