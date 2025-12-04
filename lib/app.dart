import 'package:flutter/material.dart';
import 'package:google_map_test/home.dart';
import 'package:google_map_test/hw.dart';

class GoogleMapTest extends StatefulWidget {
  const GoogleMapTest({super.key});

  @override
  State<GoogleMapTest> createState() => _GoogleMapTestState();
}

class _GoogleMapTestState extends State<GoogleMapTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Hw());
  }
}
