import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_test/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hw extends StatefulWidget {
  const Hw({super.key});

  @override
  State<Hw> createState() => _HwState();
}

class _HwState extends State<Hw> {
  Position? mylocaion;
  final List<LatLng> _myPath = [];
  Timer? t;

  // void getMyLoc() async {
  //   mylocaion = await Geolocator.getCurrentPosition();
  //   _myPath.add(LatLng(mylocaion!.latitude, mylocaion!.longitude));
  //   setState(() {});
  // }

  Future<void> check() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if ((locationPermission == LocationPermission.always ||
            locationPermission == LocationPermission.whileInUse) &&
        await Geolocator.isLocationServiceEnabled() == true) {
      // t = Timer.periodic(Duration(seconds: 10), (timer) => getMyLoc());
      Geolocator.getPositionStream(
        locationSettings: LocationSettings(timeLimit: Duration(seconds: 10)),
      ).listen((event) {
        mylocaion = event;
        _myPath.add(LatLng(event.latitude, event.longitude));
        setState(() {});
      });
    } else {
      Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    // print("sssssssssssssssss${mylocaion}");
    if (mylocaion == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Module 25 Assignment'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                icon: Icon(Icons.home_filled),
              ),
            ],
          ),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(mylocaion!.latitude, mylocaion!.longitude),
              zoom: 16,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,

            markers: {
              Marker(
                markerId: MarkerId("myloc"),
                position: LatLng(mylocaion!.latitude, mylocaion!.longitude),
                infoWindow: InfoWindow(
                  title: 'My current location',
                  snippet: mylocaion.toString(),
                ),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId('myLocation'),
                points: _myPath,
                color: Colors.blue,
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
              ),
            },
          ),
        ),
      );
    }
  }
}
