import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/common_widgets/common_back_button.dart';
import 'package:list_ur_add/common_widgets/custom_button.dart';
import 'package:list_ur_add/common_widgets/custom_input_fields.dart';
import 'package:list_ur_add/common_widgets/multiple_language_dropdown.dart';
import 'package:list_ur_add/common_widgets/multiselect_location_dropdown.dart';
import 'package:list_ur_add/common_widgets/phone_number_field.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/modules/auth/provider/auth_provider.dart';
import 'package:list_ur_add/modules/auth/views/otp_view.dart';
import 'package:list_ur_add/routes/routes.dart';
import 'package:list_ur_add/service/api_logs.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPrivacyAccepted = false;

  TextEditingController phoneController = TextEditingController();

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.loadLanguages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.clrF7F7F7,
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      CommonBackButton(iconPath: AppIcons.arrowBackIc),
                      SizedBox(height: 65.h),
                      Center(
                        child: Image.asset(
                          AppIcons.logoIc,
                          fit: BoxFit.cover,
                          height: 54.h,
                          width: 190.w,
                        ),
                      ),
                      SizedBox(height: 60.h),
                      PhoneNumberField(
                        controller: phoneController,
                        hintText: "Enter Mobile Number",
                        isPhoneNumber: true,
                        onChanged: (value) {
                          provider.checkPhoneLive(context, value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Required";
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPrivacyAccepted = !isPrivacyAccepted;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                              height: 12.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                color: isPrivacyAccepted ? AppColors.clr1289FF : Colors.white,
                                borderRadius: BorderRadius.circular(2.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: isPrivacyAccepted
                                      ? AppColors.clr1289FF
                                      : AppColors.clr687684,
                                ),
                              ),
                              child: isPrivacyAccepted
                                  ? Icon(
                                      Icons.check,
                                      size: 8.sp,
                                      color: Colors.white,
                                      weight: 120,
                                      fontWeight: FontWeight.w900,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Yes, I agree to the ',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontFamily: AppFonts.semibold,
                                      color: AppColors.clr687684,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          isPrivacyAccepted = !isPrivacyAccepted;
                                        });
                                      },
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontFamily: AppFonts.semibold,
                                      color: AppColors.clr2388FF,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, AppRoutes.policy);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      CustomButton(
                        buttonName: 'Continue',
                        onPressed: () async {
                          if (phoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please enter mobile number")),
                            );
                            return;
                          }
                          if (!isPrivacyAccepted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please accept Privacy Policy")),
                            );
                            return;
                          }

                          String purpose = provider.phoneExists ? "login" : "login";

                          await provider.sendOtp(
                            context: context,
                            phone: phoneController.text,
                            countryCode: provider.countryCode,
                            purpose: purpose,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (provider.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black38,
                    child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
