import 'package:blabla/model/ride/locations.dart';

abstract class LocationsRepository {
  Future<List<Location>> getLocations();
}
