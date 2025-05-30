class TrafficCamera {
  final String id;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String location;

  TrafficCamera({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.location,
  });

  factory TrafficCamera.fromJson(Map<String, dynamic> json) {
    return TrafficCamera(
      id: json['camera_id'],
      latitude: json['location']['latitude'],
      longitude: json['location']['longitude'],
      imageUrl: json['image'],
      location:
          '${json['location']['latitude']}, ${json['location']['longitude']}',
    );
  }
}
