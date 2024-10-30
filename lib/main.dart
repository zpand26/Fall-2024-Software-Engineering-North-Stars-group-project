import 'package:flutter/material.dart';
import 'model.dart';
import 'presenter.dart';
import 'view.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking Your Nutrients',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nutrientData = "No nutrient data loaded";

  @override
  Widget build(BuildContext context) {
    // Initialize the model and presenter here
    final model = AppModel();
    final presenter = AppPresenter(model, updateView);

    // Pass `nutrientData` to AppView as required
    return AppView(presenter, data: nutrientData);
  }

  void updateView(String newData) {
    setState(() {
      nutrientData = newData;
    });
  }
}
