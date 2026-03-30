class LocationsRepository {
  Future<String> getCurrentLocation() async {
    // In a real implementation, this would use a location service
    // to get the user's current location.
    // For now, we will just return a dummy location.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return "6A, Prek Leap, Chroy Chongvar, Phnom Penh, Cambodia";
  }
}
