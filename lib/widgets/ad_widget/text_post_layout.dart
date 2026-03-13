import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';

class TextPostLayout extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final String? highlightText;

  const TextPostLayout({super.key, required this.backgroundColor, required this.text, this.highlightText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: backgroundColor),
      child: RichText(
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: TextStyle(color: AppColors.clr141618, fontFamily: AppFonts.regular, fontSize: 14.sp),
          children: [
            TextSpan(text: "$text\n"),
            if (highlightText != null)
              TextSpan(
                text: highlightText,
                style: TextStyle(color: AppColors.clr2388FF),
              ),
          ],
        ),
      ),
    );
  }
}
