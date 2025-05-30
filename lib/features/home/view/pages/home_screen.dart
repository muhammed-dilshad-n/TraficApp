import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/model/trafic_camera_model.dart';
import 'package:flutter_application_1/features/home/view_model/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficCameraMap extends StatefulWidget {
  const TrafficCameraMap({super.key});

  @override
  _TrafficCameraMapState createState() => _TrafficCameraMapState();
}

class _TrafficCameraMapState extends State<TrafficCameraMap> {
  late Future<List<TrafficCamera>> _futureCameras;

  @override
  void initState() {
    super.initState();
    _futureCameras = Services.fetchCameras();
  }

  // Move this method inside the state class!
  Set<Marker> _createMarkers(List<TrafficCamera> cameras) {
    return cameras.map((camera) {
      return Marker(
        markerId: MarkerId(camera.id),
        position: LatLng(camera.latitude, camera.longitude),
        infoWindow: InfoWindow(
          title: 'Camera ${camera.id}',
          snippet: camera.location,
          onTap: () {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: Text('Camera ${camera.id}'),
                    content: Image.network(camera.imageUrl),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
            );
          },
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrafficCamera>>(
      future: _futureCameras,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No cameras found.'));
        }
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              snapshot.data![0].latitude,
              snapshot.data![0].longitude,
            ),
            zoom: 12,
          ),
          markers: _createMarkers(snapshot.data!),
        );
      },
    );
  }
}
