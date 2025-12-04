import 'package:flutter/material.dart';
import 'package:google_map_test/mylocaion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Google Map Test'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mylocaion()),
                );
              },
              icon: Icon(Icons.location_searching),
            ),
          ],
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(23.83034453792625, 90.42326987088322),
            zoom: 18,
          ),
          onMapCreated: (GoogleMapController controller) {
            _googleMapController = controller;
          },
          myLocationButtonEnabled: true,
          onTap: (argument) {
            debugPrint(argument.toString());
          },
          markers: {
            Marker(
              markerId: MarkerId('1'),
              position: LatLng(23.830761485841876, 90.42383227497339),
              infoWindow: InfoWindow(title: 'Office'),
            ),
            Marker(
              markerId: MarkerId('2'),
              position: LatLng(23.830254830578973, 90.4242654517293),
              infoWindow: InfoWindow(title: 'Home'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
            ),
            Marker(
              markerId: MarkerId('3'),
              position: LatLng(23.829223419107834, 90.42318418622017),
              infoWindow: InfoWindow(title: 'HQ'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
            ),
          },
          circles: {
            Circle(
              circleId: CircleId('1'),
              center: LatLng(23.830761485841876, 90.42383227497339),
              radius: 20,
              strokeWidth: 5,
              fillColor: Colors.green.withAlpha(125),
              strokeColor: Colors.orange,
            ),
            Circle(
              circleId: CircleId('2'),
              center: LatLng(23.830254830578973, 90.4242654517293),
              radius: 20,
              strokeWidth: 5,
              fillColor: Colors.red.withAlpha(125),
              strokeColor: Colors.lime,
            ),
          },
          polylines: {
            Polyline(
              polylineId: PolylineId('1'),
              points: [
                LatLng(23.830761485841876, 90.42383227497339),
                LatLng(23.830254830578973, 90.4242654517293),
              ],
              width: 5,
              color: Colors.purple,
              endCap: Cap.roundCap,
              startCap: Cap.roundCap,
            ),
          },
          polygons: {
            Polygon(
              polygonId: PolygonId('1'),
              points: [
                LatLng(23.829571210868195, 90.42291462421417),
                LatLng(23.82962886937681, 90.42349867522717),
                LatLng(23.828925924534122, 90.42340479791164),
                LatLng(23.82945129335595, 90.42393822222948),
                LatLng(23.828911203135437, 90.42371727526188),
                LatLng(23.828918563834986, 90.42298167943954),
              ],
              fillColor: Colors.orange.shade100.withAlpha(200),
              strokeColor: Colors.redAccent,
            ),
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            FloatingActionButton(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              onPressed: () {
                _googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(23.830254830578973, 90.4242654517293),
                  ),
                );
              },
              child: Icon(Icons.home),
            ),
            FloatingActionButton(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              onPressed: () {
                _googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(23.830761485841876, 90.42383227497339),
                  ),
                );
              },
              child: Icon(Icons.factory),
            ),
            FloatingActionButton(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              onPressed: () {
                _googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(23.829223419107834, 90.42318418622017),
                  ),
                );
              },
              child: Icon(Icons.home_work),
            ),
          ],
        ),
      ),
    );
  }
}
