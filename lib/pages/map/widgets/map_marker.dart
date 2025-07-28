import 'package:flutter/material.dart';
import '../../../core/app_dimensions.dart';

class MapMarker extends StatelessWidget {
  final String label;
  final Color color;

  const MapMarker({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontM,
            ),
          ),
        ),
        Icon(Icons.location_pin, size: AppDimensions.iconXL, color: color),
        SizedBox(height: 20),
      ],
    );
  }
}
