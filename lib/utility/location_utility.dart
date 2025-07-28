import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

enum LocationStatus { serviceDisable, withoutPermission, enable }

class LocationManager {
  static Future<bool> isServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  static Future<LocationStatus> hasPermissions({
    Future Function()? enableGps,
  }) async {
    bool serviceEnabled = await isServiceEnabled();
    if (!serviceEnabled) {
      await enableGps?.call();
      return LocationStatus.serviceDisable;
    }

    if (kIsWeb) return LocationStatus.withoutPermission;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return LocationStatus.withoutPermission;
    }
    return LocationStatus.enable;
  }

  static Future<bool> requestPermissions({
    Future Function()? locationPermission,
  }) async {
    final serviceEnabled = await isServiceEnabled();
    if (!serviceEnabled) return false;

    var locationStatus = await hasPermissions();
    if (locationStatus == LocationStatus.enable) return true;

    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return false;
    if (permission == LocationPermission.deniedForever && !kIsWeb) {
      await locationPermission?.call();
      return false;
    }
    return true;
  }

  static Future<LatLng?> getCurrentLocation({
    Future Function()? enableGps,
    Future Function()? locationPermission,
  }) async {
    var locationStatus = await hasPermissions(enableGps: enableGps);
    if (locationStatus != LocationStatus.enable) {
      final hasPermission = await requestPermissions();
      if (!hasPermission) return null;
    }

    try {
      final location = await Geolocator.getCurrentPosition();
      return LatLng(location.latitude, location.longitude);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> requestEnableService() async {
    if (kIsWeb) return true;
    await Geolocator.openLocationSettings();
    return false;
  }
}
