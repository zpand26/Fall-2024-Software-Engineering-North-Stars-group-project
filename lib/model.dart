class AppModel {
  //sample method to fetch or proccess data
  Future<String> fetchData() async {
    //simulating a data fetch or api call
    await Future.delayed(Duration(seconds: 2));
    return "Hello from Model!";

  }
}