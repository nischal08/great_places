import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBc0dltmCw1cFO_Vpx1_Wir7j5rilkdvb8';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double longitude, required double latitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  // static Future<String> getPlaceAddress(
  //     {required double longitude, required double latitude}) {


  // }
}
