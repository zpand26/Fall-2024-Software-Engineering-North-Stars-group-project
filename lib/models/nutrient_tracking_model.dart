import 'dart:convert';
import 'package:http/http.dart' as http;

class NutrientTrackerModel {
  final String apiKey = 'uyVCDtKVL3OVdHFuuJK3H9VY4eilAfu6SkKriuxm'; // Replace with your API Key

  // Method to fetch and process data
  Future<String> fetchData(String query) async {
    try {
      // Construct API URL
      final Uri apiUrl = Uri.parse("https://api.calorieninjas.com/v1/nutrition?query=$query");

      // Make the API call
      final response = await http.get(apiUrl, headers: {"X-Api-Key": apiKey});

      // Check if the response is successful
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> items = responseData['items'];
        
        List<String> nutrientDetails = items.map((item) {
          return '''
Name: ${item['name']}
Calories: ${item['calories']} kcal
Total Fat: ${item['fat_total_g']} g
Cholesterol: ${item['cholesterol_mg']} mg
Sodium: ${item['sodium_mg']} mg
Potassium: ${item['potassium_mg']} mg
Total Carbohydrates: ${item['carbohydrates_total_g']} g
Fiber: ${item['fiber_g']} g
Sugar: ${item['sugar_g']} g
Protein: ${item['protein_g']} g
''';
        }).toList();

        return nutrientDetails.join("\n-----------------------\n");
      } else {
        // Handle API error response
        return "Failed to load nutrient data. Status code: ${response.statusCode}";
      }
    } catch (e) {
      // Handle exceptions
      return "Error occurred: $e";
    }
  }
}
