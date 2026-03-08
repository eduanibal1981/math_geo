import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/compass/presentation/screens/compass_screen.dart';

void main() {
  runApp(const ProviderScope(child: PairOfCompassesApp()));
}

class PairOfCompassesApp extends StatelessWidget {
  const PairOfCompassesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pair of Compasses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CompassScreen(),
    );
  }
}
