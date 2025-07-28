import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_app/core/app_colors.dart';
import 'package:taxi_app/core/app_dimensions.dart';
import 'package:taxi_app/pages/map/widgets/distance_display.dart';
import 'package:taxi_app/pages/map/widgets/map_marker.dart';
import 'package:taxi_app/utility/location_utility.dart';
import 'package:taxi_app/pages/map/widgets/enable_gps_sheet.dart';
import 'package:taxi_app/pages/map/widgets/location_permission_sheet.dart';

import 'map/widgets/map_navigation_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? startPoint;
  LatLng? endPoint;
  LatLng? userCurrentLocation;
  LatLng? selectedLocation;
  final mapController = MapController();
  bool isMoving = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: startPoint == null,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (endPoint != null) {
            setState(() {
              endPoint = null;
            });
          } else if (startPoint != null) {
            setState(() {
              startPoint = null;
            });
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            child: Stack(
              children: [
                Positioned.fill(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: LatLng(
                        35.69965893241557,
                        51.337157725615405,
                      ),
                      initialZoom: 18,
                      onPointerDown: (event, location) {
                        setState(() {
                          isMoving = true;
                        });
                      },
                      onPointerUp: (event, location) {
                        setState(() {
                          isMoving = false;
                        });
                      },
                      onPositionChanged: (camera, hasGesture) {
                        selectedLocation = camera.center;
                      },
                    ),
                    children: [
                      TileLayer(
                        tileProvider: NetworkTileProvider(),
                        fallbackUrl:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        urlTemplate:
                            'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                        userAgentPackageName: 'com.example.taxi_app',
                      ),
                      if (userCurrentLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: userCurrentLocation!,
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.person_pin_circle_outlined,
                                color: Colors.grey,
                                size: AppDimensions.iconXL,
                              ),
                              rotate: true,
                            ),
                          ],
                        ),

                      /// Origin Point
                      if (startPoint != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: startPoint!,
                              width: 90,
                              height: 90,
                              child: const MapMarker(
                                label: "مبدا",
                                color: Colors.blue,
                              ),
                              rotate: true,
                            ),
                          ],
                        ),

                      /// Destination Point
                      if (endPoint != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: endPoint!,
                              width: 90,
                              height: 90,
                              child: const MapMarker(
                                label: "مقصد",
                                color: Colors.red,
                              ),
                              rotate: true,
                            ),
                          ],
                        ),

                      /// Route
                      if (startPoint != null && endPoint != null)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: [startPoint!, endPoint!],
                              color: AppColors.primaryColor,
                              strokeWidth: 4,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                /// Distance
                if (startPoint != null && endPoint != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: DistanceDisplay(
                      distance:
                          Geolocator.distanceBetween(
                            startPoint!.latitude,
                            startPoint!.longitude,
                            endPoint!.latitude,
                            endPoint!.longitude,
                          ) /
                          1000,
                    ),
                  ),

                /// Center Point
                if (startPoint == null || endPoint == null)
                  Center(
                    child: AnimatedScale(
                      scale: isMoving ? 1.3 : 1,
                      duration: const Duration(milliseconds: 100),
                      child: Icon(
                        Icons.location_pin,
                        size: AppDimensions.iconXL,
                        color: startPoint == null ? Colors.blue : Colors.red,
                      ),
                    ),
                  ),

                /// Search Current Location
                PositionedDirectional(
                  start: AppDimensions.marginL,
                  bottom: AppDimensions.marginL,
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    child: Icon(
                      Icons.location_searching,
                      size: AppDimensions.iconL,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MapNavigationButton(
          startPoint: startPoint,
          endPoint: endPoint,
          selectedLocation: selectedLocation,
          onStartPointSelected: (location) {
            setState(() {
              startPoint = location;
            });
          },
          onEndPointSelected: (location) {
            setState(() {
              endPoint = location;
            });
          },
          onTripRequested: () {
            setState(() {
              startPoint = null;
              endPoint = null;
            });
          },
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    final position = await LocationManager.getCurrentLocation(
      enableGps: _showEnableGpsSheet,
      locationPermission: _showLocationPermissionSheet,
    );
    if (position != null) {
      userCurrentLocation = position;
      selectedLocation = position;
      mapController.move(position, 18);
    }
  }

  Future _showEnableGpsSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (_) => EnableGpsSheet(),
    );
  }

  Future _showLocationPermissionSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (_) => LocationPermissionSheet(),
    );
  }
}
