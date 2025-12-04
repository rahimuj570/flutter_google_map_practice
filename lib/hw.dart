import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hw extends StatefulWidget {
  const Hw({super.key});

  @override
  State<Hw> createState() => _HwState();
}

class _HwState extends State<Hw> {
  Position? mylocaion;
  void getMyLoc() async {
    mylocaion = await Geolocator.getCurrentPosition();
    setState(() {});
  }

  bool allOK = false;
  Future<void> check() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if ((locationPermission == LocationPermission.always ||
            locationPermission == LocationPermission.whileInUse) &&
        await Geolocator.isLocationServiceEnabled() == true) {
      getMyLoc();
      allOK = true;
    } else {
      Geolocator.requestPermission();
      allOK = false;
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
    print("sssssssssssssssss${mylocaion}");
    return mylocaion == null
        ? Center(child: CircularProgressIndicator())
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(mylocaion!.latitude, mylocaion!.longitude),
              zoom: 16,
            ),
            mapType: MapType.normal,
          );
  }
}
