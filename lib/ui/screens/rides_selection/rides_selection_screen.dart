import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/ride/ride_repository.dart';
import '../../states/ride_preference_state.dart';
import 'view_model/ride_selection_model.dart';
import 'widgets/ride_selection_content.dart';

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
  late final RideSelectionModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RideSelectionModel(
      context.read<RidePreferenceState>(),
      context.read<RidesRepository>(),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RideSelectionContent(viewModel: _viewModel);
  }
}
