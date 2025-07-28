import 'package:flutter/material.dart';
import 'package:taxi_app/utility/location_utility.dart';
import 'package:taxi_app/widgets/custom_bottom_sheet.dart';

import '../../../widgets/custom_contained_button.dart';

class EnableGpsSheet extends StatelessWidget {
  const EnableGpsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: 'سرویس GPS',
      content: 'لطفا لوکیشن دستگاه خود را فعال کنید',
      button: CustomContainedButton.primary(
        onPressed: () async {
          await LocationManager.requestEnableService();
          if (context.mounted) Navigator.of(context).pop();
        },
        label: 'فعال سازی',
      ),
    );
  }
}
