import 'location_reopsitory.dart';

class LocationRepositoryMock extends LocationsRepository {
  @override
  Future<String> getCurrentLocation() async {
    // Simulate a delay to mimic network latency
    await Future.delayed(Duration(seconds: 2));
    // Return a mock location
    return "6A, Prek Leap, Chroy Chongvar, Phnom Penh, Cambodia";
  }
}
