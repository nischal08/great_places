import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBYjcPefo27rxYHqbwu4zStCFSVNmvJBHA';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double longitude, required double latitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:N%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(
      {required double longitude, required double latitude}) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final response = await http.get(
      Uri.parse(url),
    );
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
