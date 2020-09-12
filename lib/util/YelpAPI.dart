import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

const String baseurl = "https://api.yelp.com/v3/businesses/search";
const String authcode =
    "86x_HqLpCFMGCpZBGqU929_RM1wrdFGuwq9Y3S0QC2mTBszVYksauX663gTH9D9-Ps-p2SBZlZ3RjekOX94xPd0gUr0blsW1pbYgUl08Q0DVQf65tpN-q97bfzJMX3Yx";

// // String term = "Restaurant";
int radius = 40000;

Future getListofRestaurants(baseurl, radius) async {
  print("Getting List of Destinations...");
  Position position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  Position _currentPosition = position;

  print(radius);

  double latitude = _currentPosition.latitude;
  double longitude = _currentPosition.longitude;
  print(latitude);
  print(longitude);

  http.Response response = await http.get(
      baseurl +
          "?radius=" +
          radius.toString() +
          "&latitude=" +
          latitude.toString() +
          "&longitude=" +
          longitude.toString(),
      headers: {"Authorization": "Bearer " + authcode});

  return response.body;
}
