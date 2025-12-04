import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mylocaion extends StatefulWidget {
  const Mylocaion({super.key});

  @override
  State<Mylocaion> createState() => _MylocaionState();
}

class _MylocaionState extends State<Mylocaion> {
  Position? loc;

  Future<void> _getLoc(VoidCallback onSuccessCall) async {
    print('testtt call');
    bool isGPSOn = await Geolocator.isLocationServiceEnabled();
    if (isGPSOn) {
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.whileInUse) {
        onSuccessCall();
      } else {
        await Geolocator.requestPermission();
        print('permission not granted');
        await _getLoc(onSuccessCall);
      }
    } else {
      print("Need to on GPS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Location'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My Location= \n$loc', style: TextStyle(fontSize: 20)),
              FilledButton(
                onPressed: () => _getLoc(() async {
                  loc = await Geolocator.getCurrentPosition();
                  setState(() {});
                }),
                child: Text('Get Location'),
              ),
              FilledButton(
                onPressed: () => _getLoc(() {
                  Geolocator.getPositionStream().listen((position) async {
                    loc = await Geolocator.getCurrentPosition();
                    setState(() {});
                  });
                }),
                child: Text('Get Realtime Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
