import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:datingo/models/location_model.dart';

import '../repositories.dart';

class LocationRepository extends BaseLocationRepository {
  final String key = 'AIzaSyB_HajY1KFBhaQfnm0K0d3obNaE4fMWeis';
  final String types = 'geocode';

  static const baseUrl = 'https://maps.googleapis.com/maps/api/place';
  @override
  Future<Location> getLocation(String location) async {
    final String url =
        '$baseUrl/findplacefromtext/json?fields=place_id%2Cname%2Cgeometry&input=$location&inputtype=textquery&key=$key';

    http.Response response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    var results = json['candidates'][0] as Map<String, dynamic>;

    return Location.fromSnapshot(results);
  }
}
