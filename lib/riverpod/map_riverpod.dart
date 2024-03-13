import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationData {
  final LatLng? position;
  final String? address;
  LocationData({this.position, this.address});
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationData>(
  (ref) => LocationNotifier(),
);

// ===========> LOCATION NOTIFIER
class LocationNotifier extends StateNotifier<LocationData> {
  LocationNotifier() : super(LocationData());
  Future<void> determinePositionAndAddress() async {
    LocationPermission permission;
    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      state = LocationData(
          position: LatLng(position.latitude, position.longitude),
          // address: "${placemarks.first}"
          address:
              "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.isoCountryCode}"
          // "${placemarks.first.street!}, ${placemarks.first.locality!}, ${placemarks.first.country}",
          );
    } catch (error) {
      debugPrint('Error getting location: $error');
    }
  }

  void passAddress(String address) {}
}
