import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepository {
  Future<List<RidePreference>> getRidePreferences() async {
    // Simulate a delay to mimic network latency
    await Future.delayed(Duration(seconds: 2));
    // Return a list of mock ride preferences
    return [];
  }
}
