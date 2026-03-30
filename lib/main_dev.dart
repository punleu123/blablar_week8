import 'package:provider/provider.dart';
import 'main_common.dart';
import 'data/repositories/location/location_reopsitory.dart';
import 'data/repositories/location/location_repository_mock.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride/ride_repository_mock.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository_mock.dart';

void main() {
  // Here we are using the mock repositories.
  // In a real-world scenario, you would have a main_prod.dart
  // that would inject the real repositories.
  mainCommon([
    Provider<LocationsRepository>(create: (_) => LocationRepositoryMock()),
    Provider<RidesRepository>(create: (_) => RideRepositoryMock()),
    Provider<RidePreferenceRepository>(
      create: (_) => RidePreferenceRepositoryMock(),
    ),
    // We will add the states here later
  ]);
}
