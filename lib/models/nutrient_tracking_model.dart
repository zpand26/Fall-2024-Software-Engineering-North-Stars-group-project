import 'dart:convert';
import 'package:http/http.dart' as http;

class NutrientTrackerModel {
  final String apiKey = '79n8vpyNTmXxllhKErgDaA==EC2OYSI7NOruHPat';
  //sample method to fetch or proccess data
  Future<String> fetchData(String query) async {
    //simulating a data fetch or api call
    final response = await http.get(
        Uri.parse("https://api.calorieninjas.com/v1/nutrition?query=$query"),
        headers:{"X-Api-Key": apiKey}
    );

    if (response.statusCode == 200){
      //parsing JSON response to get nutrient information
      final data = json.decode(response.body);

      //extracting relevant nutrient information for display
      String nutrientSummary = data['items'].map((item){
        return "${item['name']}: ${item['calories']} kcal";
      }).join("\n");
      return nutrientSummary;
    } else {
      //handle API error response
      return "Failed to load nutrient data";
    }



  }
// await Future.delayed(Duration(seconds: 2));
// return "Nutrient Summary: !";
}