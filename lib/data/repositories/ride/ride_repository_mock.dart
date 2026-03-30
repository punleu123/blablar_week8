import 'ride_repository.dart';

class RideRepositoryMock extends RidesRepository {
  @override
  Future<List<String>> getAvailableRides(String from, String to) async {
    // Simulate a delay to mimic network latency
    await Future.delayed(Duration(seconds: 1));
    // Return a list of mock rides
    return [
      "Ride from $from to $to at 10:00 AM",
      "Ride from $from to $to at 2:00 PM",
      "Ride from $from to $to at 6:00 PM",
    ];
  }
}
