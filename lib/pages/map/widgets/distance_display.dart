import 'package:flutter/material.dart';
import '../../../core/app_dimensions.dart';

class DistanceDisplay extends StatelessWidget {
  final double distance;

  const DistanceDisplay({super.key, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingS),
      margin: EdgeInsets.all(AppDimensions.marginM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'فاصله: ${distance < 1 ? '${(distance * 1000).toStringAsFixed(0)} متر' : '${distance.toStringAsFixed(2)} کیلومتر'}',
        style: TextStyle(
          fontSize: AppDimensions.fontL,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
