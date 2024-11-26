import 'package:flutter/material.dart';
import '../presenters/nutrient_tracking_presenter.dart';

class NutrientTrackingView extends StatefulWidget {
  final NutrientTrackingPresenter presenter;

  const NutrientTrackingView(this.presenter, {super.key});

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
        title: const Text('Nutrient Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Section
              TextField(
                controller: _queryController,
                decoration: InputDecoration(
                  labelText: 'Enter food items',
                  labelStyle: TextStyle(color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.food_bank, color: Colors.teal),
                ),
              ),
              const SizedBox(height: 16),
              // Button Section
              ElevatedButton.icon(
                onPressed: () => widget.presenter.loadData(_queryController.text),
                icon: const Icon(Icons.search),
                label: const Text('Show Nutrient Summary'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Result Section
              if (data.isNotEmpty)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nutrient Summary:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Center(
                  child: Text(
                    'Enter food items to see the summary.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
