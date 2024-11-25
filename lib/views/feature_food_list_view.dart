import 'package:flutter/material.dart';
import '../presenters/feature_food_list_presenter.dart';
import '../views/filter_page_view.dart';

class FeatureFoodListView extends StatefulWidget {
  final FeatureFoodListPresenter presenter;

  FeatureFoodListView({Key? key, required this.presenter}) : super(key: key);

  @override
  _FeatureFoodListViewState createState() => _FeatureFoodListViewState();
}

class _FeatureFoodListViewState extends State<FeatureFoodListView> {
  List<String> displayedFoods = [];

  @override
  void initState() {
    super.initState();
    // Set up the callback to update the displayed food list
    widget.presenter.updateView = (foods) {
      setState(() {
        displayedFoods = _sortFoods(foods);
      });
    };
    // Initially display all foods sorted
    displayedFoods = _sortFoods(widget.presenter.model.allFoods);
  }

  // Method to open the Filter Page as a separate view
  void _openFilterPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(presenter: widget.presenter),
      ),
    );
    setState(() {
      displayedFoods = _sortFoods(
          widget.presenter.model.applyFilters(widget.presenter.selectedFilters));
    });
  }

  // Sort function to put favorites at the top
  List<String> _sortFoods(List<String> foods) {
    return foods
      ..sort((a, b) {
        final isAFavorite = widget.presenter.model.favoriteFoods.contains(a);
        final isBFavorite = widget.presenter.model.favoriteFoods.contains(b);
        if (isAFavorite && !isBFavorite) {
          return -1;
        } else if (!isAFavorite && isBFavorite) {
          return 1;
        }
        return 0;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food List"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _openFilterPage, // Open the filter page
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: displayedFoods.length,
        itemBuilder: (context, index) {
          final food = displayedFoods[index];
          final isFavorite = widget.presenter.model.favoriteFoods.contains(food);
          return ListTile(
            title: Text(food),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  widget.presenter.toggleFavoriteFood(food);
                  displayedFoods = _sortFoods(displayedFoods); // Re-sort after toggling
                });
              },
            ),
          );
        },
      ),
    );
  }
}