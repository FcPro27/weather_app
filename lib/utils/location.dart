import 'package:location/location.dart';

class LocationHelper {

    double latitude=0.0;
    double longitude=0.0;

  Future<void> getCurrentLocation() async {
    Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationdata;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationdata = await location.getLocation();
      latitude =  _locationdata.latitude!;
      longitude = _locationdata.longitude!;
      
    }
  }

