import 'package:blabla/ui/screens/home/home_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/states/ride_preference_state.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Global States (require MaterialApp context)
        ChangeNotifierProvider<RidePreferenceState>(
          create: (context) => RidePreferenceState(
            context.read<RidePreferenceRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BlaBlaCar",
        theme: blaTheme,
        home: HomeScreen(),
      ),
    );
  }
}
