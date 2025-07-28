import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/core/app_colors.dart';
import 'package:taxi_app/utility/location_utility.dart';
import 'package:taxi_app/widgets/custom_bottom_sheet.dart';

import '../../../widgets/custom_contained_button.dart';

class LocationPermissionSheet extends StatelessWidget {
  const LocationPermissionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      icon: Container(
        width: 64.r,
        height: 64.r,
        margin: EdgeInsets.all(6.r),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Icon(
          Icons.location_searching,
          size: 32.w,
          color: AppColors.backgroundColor,
        ),
      ),
      title: 'دسترسی به لوکیشن',
      content:
          'برای استفاده از این سرویس، لطفاً دسترسی به موقعیت جغرافیایی خود را فعال کنید.',
      button: CustomContainedButton.primary(
        onPressed: () async {
          await LocationManager.requestPermissions();
          if (context.mounted) Navigator.of(context).pop();
        },
        label: 'تنظیمات لوکیشن',
      ),
    );
  }
}
