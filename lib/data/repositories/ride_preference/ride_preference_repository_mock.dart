import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock extends RidePreferenceRepository {
  @override
  Future<List<RidePreference>> getRidePreferences() async {
    // Simulate a delay to mimic network latency
    await Future.delayed(Duration(seconds: 3));
    // Return a list of mock ride preferences
    return [];
  }
}
