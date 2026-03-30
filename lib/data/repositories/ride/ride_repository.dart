import '../../../model/ride/ride.dart';

class RidesRepository {
  Future<List<Ride>> getRides() async {
    // In a real implementation, this would make a network request
    // to fetch available rides.
    // For now, we will just return an empty list.
    return [];
  }
}