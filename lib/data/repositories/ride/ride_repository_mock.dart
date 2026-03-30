import '../../dummy_data.dart';
import '../../../model/ride/ride.dart';
import 'ride_repository.dart';

class RideRepositoryMock extends RidesRepository {
  @override
  Future<List<Ride>> getRides() async {
    // Simulate a delay to mimic network latency
    await Future.delayed(Duration(seconds: 1));
    // Return mock rides from dummy data
    return fakeRides;
  }
}
