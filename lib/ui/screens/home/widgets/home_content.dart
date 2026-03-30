import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/animations_util.dart';
import '../../../theme/theme.dart';
import '../../../widgets/pickers/bla_ride_preference_picker.dart';
import '../../rides_selection/rides_selection_screen.dart';
import '../view_model/home_model.dart';
import 'home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

/// Home Content - Pure UI component
/// Receives HomeModel and builds the UI based on its data
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the ViewModel for changes
    final viewModel = context.watch<HomeModel>();

    return Stack(
      children: [
        _buildBackground(),
        _buildForeground(context, viewModel),
      ],
    );
  }

  void _onRidePrefSelected(BuildContext context, HomeModel viewModel, RidePreference selectedPreference) async {
    // 1- Update the preference via ViewModel
    viewModel.selectPreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()),
    );

    // Note: No setState() needed! ViewModel handles updates automatically
  }

  Widget _buildForeground(BuildContext context, HomeModel viewModel) {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              Material(
                color: Colors.transparent,
                child: BlaRidePreferencePicker(
                  initRidePreference: viewModel.currentPreference,
                  onRidePreferenceSelected: (pref) => _onRidePrefSelected(context, viewModel, pref),
                ),
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(context, viewModel),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context, HomeModel viewModel) {
    // Get reversed history from ViewModel
    List<RidePreference> history = viewModel.history.reversed.toList();
    
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => _onRidePrefSelected(context, viewModel, history[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
