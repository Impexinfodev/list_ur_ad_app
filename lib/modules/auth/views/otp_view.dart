import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/common_widgets/common_back_button.dart';
import 'package:list_ur_add/common_widgets/custom_button.dart';
import 'package:list_ur_add/common_widgets/custom_input_fields.dart';
import 'package:list_ur_add/common_widgets/custom_otp_fields.dart';
import 'package:list_ur_add/common_widgets/multiple_language_dropdown.dart';
import 'package:list_ur_add/common_widgets/multiselect_location_dropdown.dart';
import 'package:list_ur_add/common_widgets/phone_number_field.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/modules/auth/provider/auth_provider.dart';
import 'package:list_ur_add/routes/routes.dart';
import 'package:provider/provider.dart';

class OtpView extends StatefulWidget {
  final String phone;
  final String countryCode;
  final String purpose;

  const OtpView({super.key, required this.phone, required this.countryCode, required this.purpose});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.clrF7F7F7,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CommonBackButton(iconPath: AppIcons.arrowBackIc),
                      ),
                      SizedBox(height: 46.h),
                      Center(
                        child: Image.asset(
                          AppIcons.logoIc,
                          fit: BoxFit.contain,
                          height: 50.h,
                          width: 180.w,
                        ),
                      ),
                      SizedBox(height: 26.h),
                      Text(
                        'We have sent a verification code to',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: AppFonts.semibold,
                          color: AppColors.clr687684,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.countryCode}${widget.phone}",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15.sp,
                              fontFamily: AppFonts.bold,
                              color: AppColors.clr092642,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Edit?',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: AppFonts.bold,
                                color: AppColors.clr2388FF,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22.h),
                      CustomOtpField(
                        onCompleted: (value) {
                          provider.otpController.text = value.trim();
                        },
                      ),
                      SizedBox(height: 6.h),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            provider.reSendOtp(
                              context: context,
                              phone: widget.phone,
                              countryCode: widget.countryCode,
                              purpose: widget.purpose,
                            );
                          },
                          child: Text(
                            'Resend OTP?',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: AppFonts.medium,
                              color: AppColors.clr19213D,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 121.h),
                      CustomButton(
                        buttonName: 'Continue',
                        onPressed: () {
                          if (provider.otpController.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a 6-digit OTP')),
                            );
                            return;
                          }
                          provider.verifyOtp(
                            context,
                            widget.phone,
                            widget.countryCode,
                            provider.otpController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (provider.isVerified)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Container(
                    width: 193.w,
                    height: 160.h,
                    padding: EdgeInsets.symmetric(vertical: 33.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.clrF0F7FF),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.clr2388FF.withOpacity(0.30),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppIcons.checkIc,
                          height: 66.h,
                          width: 66.w,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "Verified",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: AppFonts.semibold,
                            color: AppColors.clr2388FF,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// Container(
//   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//   decoration: BoxDecoration(
//     shape: BoxShape.circle,
//     color: AppColors.clr2388FF.withOpacity(0.30),
//     boxShadow: [
//       BoxShadow(
//         color: AppColors.clr2388FF.withOpacity(0.20),
//         blurRadius: 20,
//         offset: const Offset(0, 0),
//       ),
//     ],
//   ),
//   child: Container(
//     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: AppColors.clr2388FF,
//     ),
//     child: Image.asset(
//       AppIcons.checkIc,
//       height: 20.h,
//       width: 27.w,
//       fit: BoxFit.cover,
//     ),
//   ),
// ),
