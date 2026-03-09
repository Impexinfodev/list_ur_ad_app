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
import 'package:list_ur_add/util/utils.dart';
import 'package:provider/provider.dart';

class LocationSelectionView extends StatefulWidget {
  const LocationSelectionView({super.key});

  @override
  State<LocationSelectionView> createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {
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
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: .start,
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
                  MultiSelectLocationDropdown(),
                  SizedBox(height: 50.h),
                  CustomButton(
                    buttonName: 'Continue',
                    onPressed: () async {
                      final provider = Provider.of<AuthProvider>(context, listen: false);

                      provider.applySelection();
                      provider.setLocations(provider.selectedLocations.map((e) => e.id).toList());
                      provider.registrationData.name = "User";
                      provider.registrationData.phone = provider.phoneNumber;
                      provider.registrationData.countryCode = provider.countryCode;
                      provider.registrationData.isPrivacyAccepted = true;
                      if (provider.tempToken == null || provider.tempToken!.isEmpty) {
                        errorToast(context, 'Verification token missing!');
                        return;
                      }
                      await provider.registerUser(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
