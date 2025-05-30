import 'dart:convert';

import 'package:flutter_application_1/features/home/model/trafic_camera_model.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<TrafficCamera>> fetchCameras() async {
    final response = await http.get(
      Uri.parse('https://api.data.gov.sg/v1/transport/traffic-images'),
    );
    if (response.statusCode == 200) {
      final List cameras = json.decode(response.body)['items'][0]['cameras'];
      return cameras.map((json) => TrafficCamera.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cameras');
    }
  }
}
