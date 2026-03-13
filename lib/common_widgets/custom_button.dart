import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final Color textColor;
  final double? width;
  final double? height;
  final double fontSize;
  final double borderRadius;
  final Color borderColor;
  final Gradient? borderGradient;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final Widget? leading;
  final Widget? leading1;
  final bool isLoading;
  final Color? boxShadowColor;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.backgroundColor = AppColors.mainColor,
    this.backgroundGradient,
    this.textColor = Colors.white,
    this.fontSize = 17.5,
    this.borderRadius = 14.0,
    this.width,
    this.height = 42.0,
    this.borderColor = Colors.transparent,
    this.borderGradient,
    this.borderWidth = 0.0,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 8.0),
    this.leading,
    this.leading1,
    this.isLoading = false,
    this.boxShadowColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = isLoading
        ? SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: textColor, strokeWidth: 2.5))
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, SizedBox(width: 12.w)],
              Flexible(
                child: Text(
                  buttonName,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: AppFonts.medium,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              if (leading1 != null) ...[leading1!, const SizedBox(width: 12)],
            ],
          );

    if (borderGradient != null) {
      return GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(gradient: borderGradient, borderRadius: BorderRadius.circular(borderRadius)),
              ),
              Container(
                margin: EdgeInsets.all(borderWidth),
                decoration: BoxDecoration(
                  color: backgroundGradient == null
                      ? (isLoading ? AppColors.mainColor.withOpacity(0.7) : backgroundColor)
                      : null,
                  gradient: backgroundGradient,
                  borderRadius: BorderRadius.circular(borderRadius - borderWidth),
                ),
                alignment: Alignment.center,
                child: buttonChild,
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: (boxShadowColor ?? AppColors.clr2388FF.withOpacity(0.20)),
              spreadRadius: 0,
              offset: const Offset(0, 0),
              blurRadius: 10,
            ),
          ],
          color: backgroundGradient == null
              ? (isLoading ? AppColors.mainColor.withOpacity(0.7) : backgroundColor)
              : null,
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        alignment: Alignment.center,
        child: buttonChild,
      ),
    );
  }
}
