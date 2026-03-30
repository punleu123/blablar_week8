import 'package:flutter/material.dart';
import '../../../../model/ride/ride.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/animations_util.dart' show AnimationUtils;
import '../../../theme/theme.dart';
import '../view_model/ride_selection_model.dart';
import 'ride_preference_modal.dart';
import 'rides_selection_header.dart';
import 'rides_selection_tile.dart';

/// Ride Selection Content - Pure UI component
/// Receives RideSelectionModel and builds the UI based on its data
class RideSelectionContent extends StatelessWidget {
  const RideSelectionContent({super.key, required this.viewModel});

  final RideSelectionModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final pref = viewModel.currentPreference;

        if (pref == null) {
          return const Scaffold(
            body: Center(child: Text('No ride preference selected')),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              left: BlaSpacings.m,
              right: BlaSpacings.m,
              top: BlaSpacings.s,
            ),
            child: Column(
              children: [
                RideSelectionHeader(
                  ridePreference: pref,
                  onBackPressed: () => _onBackTap(context),
                  onFilterPressed: () => _onFilterPressed(context, viewModel),
                  onPreferencePressed: () =>
                      _onPreferencePressed(context, viewModel),
                ),
                const SizedBox(height: 100),
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildRidesList(context, viewModel),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRidesList(BuildContext context, RideSelectionModel viewModel) {
    final rides = viewModel.matchingRides;

    if (rides.isEmpty) {
      return Center(
        child: Text(
          'No rides found matching your criteria',
          style: BlaTextStyles.body,
        ),
      );
    }

    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (ctx, index) => RideSelectionTile(
        ride: rides[index],
        onPressed: () => _onRideSelected(context, rides[index]),
      ),
    );
  }

  void _onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFilterPressed(BuildContext context, RideSelectionModel viewModel) {
    // TODO: Implement filter functionality
  }

  void _onRideSelected(BuildContext context, Ride ride) {
    // TODO: Navigate to ride details or booking
  }

  void _onPreferencePressed(
    BuildContext context,
    RideSelectionModel viewModel,
  ) async {
    final currentPref = viewModel.currentPreference;
    if (currentPref == null) return;

    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: currentPref),
          ),
        );

    if (newPreference != null && context.mounted) {
      // 2 - Update via ViewModel
      viewModel.selectPreference(newPreference);
      // Note: No setState() needed! ViewModel notifies automatically
    }
  }
}
