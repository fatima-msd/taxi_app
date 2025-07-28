import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';

class CustomContainedButton extends StatefulWidget {
  final String label;
  final Future Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomContainedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  factory CustomContainedButton.primary({
    required String label,
    required Future Function()? onPressed,
  }) {
    return CustomContainedButton(
      label: label,
      onPressed: onPressed,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.textDark,
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _CustomContainedButtonState();
  }
}

class _CustomContainedButtonState extends State<CustomContainedButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () async {
              if (widget.onPressed != null) {
                setState(() {
                  isLoading = true;
                });
                await widget.onPressed?.call();
                setState(() {
                  isLoading = false;
                });
              }
            },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              widget.label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }
}
