import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/model/ride/locations.dart';

import 'location_reopsitory.dart';

class LocationRepositoryMock implements LocationsRepository {
  @override
  Future<List<Location>> getLocations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return fakeLocations;
  }
}
