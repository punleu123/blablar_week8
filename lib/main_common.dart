import 'package:blabla/ui/screens/home/home_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BlaBlaCar",
      theme: blaTheme,
      home: HomeScreen(),
    );
  }
}
