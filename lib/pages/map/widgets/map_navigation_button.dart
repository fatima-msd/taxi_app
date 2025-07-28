import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_app/core/app_colors.dart';
import 'package:taxi_app/widgets/custom_contained_button.dart';

class MapNavigationButton extends StatelessWidget {
  final LatLng? startPoint;
  final LatLng? endPoint;
  final LatLng? selectedLocation;
  final Function(LatLng?) onStartPointSelected;
  final Function(LatLng?) onEndPointSelected;
  final VoidCallback onTripRequested;

  const MapNavigationButton({
    super.key,
    required this.startPoint,
    required this.endPoint,
    required this.selectedLocation,
    required this.onStartPointSelected,
    required this.onEndPointSelected,
    required this.onTripRequested,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildNavigationButton(context),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    if (startPoint == null) {
      return CustomContainedButton.primary(
        onPressed: () async {
          onStartPointSelected(selectedLocation);
        },
        label: 'انتخاب مبدا',
      );
    } else if (endPoint == null) {
      return CustomContainedButton.primary(
        onPressed: () async {
          onEndPointSelected(selectedLocation);
        },
        label: 'انتخاب مقصد',
      );
    }

    return CustomContainedButton.primary(
      onPressed: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.successColor,
            content: Center(
              child: Text(
                "«سفر با موفقیت ثبت شد.»",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            duration: Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        onTripRequested();
      },
      label: 'درخواست سفر',
    );
  }
}
