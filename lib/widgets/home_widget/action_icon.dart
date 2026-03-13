import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';

class ActionIcon extends StatelessWidget {
  final String icon;
  final String? text;
  final double iconSize;
  final double spacing;
  final Color? iconColor;

  const ActionIcon({
    super.key,
    required this.icon,
    this.text,
    this.iconSize = 15,
    this.spacing = 3.0,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          height: iconSize.h,
          width: iconSize.w,
          fit: BoxFit.contain,
          color: iconColor,
        ),
        if (text != null) ...[
          SizedBox(width: spacing.w),
          Text(
            text!,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: AppFonts.regular,
              color: AppColors.clr687684,
            ),
          ),
        ],
      ],
    );
  }
}
