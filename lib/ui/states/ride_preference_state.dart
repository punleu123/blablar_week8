import 'package:flutter/foundation.dart';
import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

/// Global state for managing ride preferences
/// Handles:
/// - Current selected preference
/// - History of past preferences
/// - Loading preferences from repository
class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository _repository;

  // Current selected preference
  RidePreference? _currentPreference;
  
  // History of preferences
  List<RidePreference> _history = [];
  
  // Loading state
  bool _isLoading = false;

  RidePreferenceState(this._repository) {
    _loadHistory();
  }

  // Getters
  RidePreference? get currentPreference => _currentPreference;
  List<RidePreference> get history => List.unmodifiable(_history);
  bool get isLoading => _isLoading;

  /// Load preference history from repository
  Future<void> _loadHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _history = await _repository.getRidePreferences();
    } catch (e) {
      debugPrint('Error loading ride preferences: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Select a new ride preference
  /// - Updates current preference if different
  /// - Adds to history if not already present
  /// - Notifies listeners
  void selectPreference(RidePreference preference) {
    // Only update if different from current
    if (_currentPreference == preference) {
      return;
    }

    _currentPreference = preference;

    // Add to history if not already there
    if (!_history.contains(preference)) {
      _history.insert(0, preference); // Add to beginning
    } else {
      // Move to front if already exists
      _history.remove(preference);
      _history.insert(0, preference);
    }

    notifyListeners();
  }

  /// Clear current preference
  void clearCurrentPreference() {
    _currentPreference = null;
    notifyListeners();
  }
}
