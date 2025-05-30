import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/view/pages/home_screen.dart';

void main() {
  runApp(TraficMap());
}

class TraficMap extends StatelessWidget {
  const TraficMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TrafficCameraMap());
  }
}
