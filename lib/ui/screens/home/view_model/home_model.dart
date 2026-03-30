import 'package:flutter/foundation.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../states/ride_preference_state.dart';

/// ViewModel for Home Screen
/// Manages the connection between RidePreferenceState and Home UI
class HomeModel extends ChangeNotifier {
  final RidePreferenceState _ridePreferenceState;

  HomeModel(this._ridePreferenceState) {
    // IMPORTANT: Listen to global state changes
    _ridePreferenceState.addListener(_onStateChanged);
  }

  /// Called when the global RidePreferenceState changes
  void _onStateChanged() {
    notifyListeners(); // Notify the UI to rebuild
  }

  // Getters - expose data from global state
  RidePreference? get currentPreference => _ridePreferenceState.currentPreference;
  
  List<RidePreference> get history => _ridePreferenceState.history;
  
  bool get isLoading => _ridePreferenceState.isLoading;

  // Actions
  void selectPreference(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }

  @override
  void dispose() {
    // IMPORTANT: Unlisten when disposing to prevent memory leaks
    _ridePreferenceState.removeListener(_onStateChanged);
    super.dispose();
  }
}
