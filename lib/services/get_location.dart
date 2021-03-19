import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  final LocationData locationResult = await Location().getLocation();
  return locationResult;
}
