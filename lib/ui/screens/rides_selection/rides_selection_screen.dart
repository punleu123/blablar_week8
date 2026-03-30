import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../services/rides_service.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../states/ride_preference_state.dart';
import '../../theme/theme.dart';
import 'widgets/ride_preference_modal.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  void onBackTap() {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference? get selectedRidePreference =>
      context.watch<RidePreferenceState>().currentPreference;

  List<Ride> get matchingRides {
    final pref = selectedRidePreference;
    if (pref == null) return [];
    return RidesService.getRidesFor(pref);
  }

  void onPreferencePressed() async {
    final currentPref = selectedRidePreference;
    if (currentPref == null) return;

    if (!mounted) return;

    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: currentPref),
          ),
        );

    if (newPreference != null && mounted) {
      // 2 - Update via global state
      context.read<RidePreferenceState>().selectPreference(newPreference);
      // Note: No setState() needed! State updates automatically
    }
  }

  @override
  Widget build(BuildContext context) {
    final pref = selectedRidePreference;
    
    // If no preference selected, show error or redirect
    if (pref == null) {
      return Scaffold(
        body: Center(
          child: Text('No ride preference selected'),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: pref,
              onBackPressed: onBackTap,
              onFilterPressed: onFilterPressed,
              onPreferencePressed: onPreferencePressed,
            ),
        
            SizedBox(height: 100),
        
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: matchingRides[index],
                  onPressed: () => onRideSelected(matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
