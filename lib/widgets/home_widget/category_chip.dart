import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';

class CategoryChip extends StatelessWidget {
  final String title;

  const CategoryChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000.r),
        border: Border.all(color: AppColors.clrF1F3F7, width: 1.6.w),
        boxShadow: [BoxShadow(color: AppColors.clr2388FF.withOpacity(0.10), blurRadius: 6, offset: const Offset(0, 0))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: AppFonts.semibold,
              color: AppColors.clr687684,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 20.w),
          Image.asset(AppIcons.filterIc, height: 12.h, width: 12.w, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
