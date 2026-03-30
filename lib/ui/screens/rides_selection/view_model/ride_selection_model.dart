import 'package:flutter/foundation.dart';
import '../../../../data/repositories/ride/ride_repository.dart';
import '../../../../model/ride/ride.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../states/ride_preference_state.dart';

/// ViewModel for Ride Selection Screen
/// Manages rides list and computes matching rides based on current preference
class RideSelectionModel extends ChangeNotifier {
  final RidePreferenceState _ridePreferenceState;
  final RidesRepository _ridesRepository;

  List<Ride> _allRides = [];
  bool _isLoading = true;

  RideSelectionModel(this._ridePreferenceState, this._ridesRepository) {
    // IMPORTANT: Listen to preference state changes
    _ridePreferenceState.addListener(_onStateChanged);
    _loadRides();
  }

  /// Called when the global RidePreferenceState changes
  void _onStateChanged() {
    notifyListeners(); // Notify UI to rebuild with new preference
  }

  /// Load all rides from repository
  Future<void> _loadRides() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allRides = await _ridesRepository.getRides();
    } catch (e) {
      debugPrint('Error loading rides: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Getters - expose data from state and repository
  RidePreference? get currentPreference =>
      _ridePreferenceState.currentPreference;

  List<RidePreference> get history => _ridePreferenceState.history;

  List<Ride> get allRides => _allRides;

  bool get isLoading => _isLoading;

  /// Compute matching rides based on current preference and filters
  /// This is the BUSINESS LOGIC - computed in ViewModel
  List<Ride> get matchingRides {
    final pref = currentPreference;
    if (pref == null) return [];

    // Filter rides based on preference
    return _allRides.where((ride) {
      // Match departure and arrival locations
      final departureMatch = ride.departureLocation == pref.departure;
      final arrivalMatch = ride.arrivalLocation == pref.arrival;

      // Match available seats
      final seatsMatch = ride.remainingSeats >= pref.requestedSeats;

      // Match date
      final dateMatch = DateTimeUtils.isSameDay(
        ride.departureDate,
        pref.departureDate,
      );

      // Filter out rides that accept pets (if preference says no pets? - not in preference yet)
      // For now, just match basic criteria

      return departureMatch && arrivalMatch && seatsMatch && dateMatch;
    }).toList();
  }

  // Actions
  void selectPreference(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }

  @override
  void dispose() {
    // IMPORTANT: Unlisten to prevent memory leaks
    _ridePreferenceState.removeListener(_onStateChanged);
    super.dispose();
  }
}
