import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/common_widgets/custom_button.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/modules/dashboard/views/dashboard_view.dart';
import 'package:list_ur_add/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OtherInfo> otherInfoItems = [
      OtherInfo(
        image: AppIcons.languageIc,
        title: 'Language',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.language);
        },
      ),
      OtherInfo(
        image: AppIcons.walletIc,
        title: 'Payment History',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.paymentHistory);
        },
      ),
      OtherInfo(
        image: AppIcons.billingIc,
        title: 'Billing',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.billing);
        },
      ),
      OtherInfo(
        image: AppIcons.alertIc,
        title: 'Alerts',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.alert);
        },
      ),
      OtherInfo(
        image: AppIcons.drawerNotificationIc,
        title: 'Notifications',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardView(index: 2)));
        },
      ),
      OtherInfo(
        image: AppIcons.archivesIc,
        title: 'Archives',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.archive);
        },
      ),
      OtherInfo(
        image: AppIcons.supportIc,
        title: 'Support',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.support);
        },
      ),
      OtherInfo(
        image: AppIcons.settingIc,
        title: 'Setting',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.setting);
        },
      ),
      OtherInfo(
        image: AppIcons.logoutIc,
        title: 'Logout',
        onTap: () {
          showLogoutDialog(context);
        },
      ),
    ];
    return Drawer(
      width: 260.w,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.clr2388FF.withOpacity(0.10),
              blurRadius: 6,
              offset: Offset(6, 0),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profile);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 20.w, right: 20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.clrD9D9D9, width: 1.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: AppColors.clr2388FF,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.clr2388FF.withOpacity(0.30),
                                  blurRadius: 6,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              'A',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.regular,
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.clr2388FF.withOpacity(0.30),
                                  blurRadius: 6,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              AppIcons.editIc,
                              height: 14.h,
                              width: 14.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Anurag Sharma',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.bold,
                          fontSize: 16.sp,
                          color: AppColors.clr141619,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '+91 9702132545',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.regular,
                          fontSize: 12.sp,
                          color: AppColors.clr3B4C5D,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Jaipur, Rajasthan 302021, India',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.regular,
                          fontSize: 12.sp,
                          color: AppColors.clr3B4C5D,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                '15k',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.medium,
                                  fontSize: 12.sp,
                                  color: AppColors.clr141619,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.regular,
                                  fontSize: 12.sp,
                                  color: AppColors.clr3B4C5D,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 14.w),
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                '10',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.medium,
                                  fontSize: 12.sp,
                                  color: AppColors.clr141619,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Live Ads',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.regular,
                                  fontSize: 12.sp,
                                  color: AppColors.clr3B4C5D,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 14.w),
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                '18',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.medium,
                                  fontSize: 12.sp,
                                  color: AppColors.clr141619,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Total Ads',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.regular,
                                  fontSize: 12.sp,
                                  color: AppColors.clr3B4C5D,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                  itemCount: otherInfoItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: otherInfoItems[index].onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Row(
                          children: [
                            Image.asset(
                              otherInfoItems[index].image,
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 14.w),
                            Text(
                              otherInfoItems[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.medium,
                                fontSize: 16.sp,
                                color: otherInfoItems[index].title == 'Logout'
                                    ? AppColors.clr2388FF
                                    : AppColors.clr141619,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 15);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [BoxShadow(color: AppColors.clr2388FF.withOpacity(0.20), blurRadius: 20)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Log Out?',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: AppFonts.semibold,
                    color: AppColors.clr2388FF,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: AppFonts.regular,
                    color: AppColors.clr19213D,
                  ),
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonName: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        borderColor: AppColors.clr2388FF,
                        borderWidth: 2.w,
                        backgroundColor: Colors.white,
                        textColor: AppColors.clr1289FF,
                        boxShadowColor: AppColors.clr2388FF.withOpacity(0.20),
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Expanded(
                      child: CustomButton(
                        buttonName: 'Logout',
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove("access_token");
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.login,
                            (route) => false,
                          );
                        },
                        boxShadowColor: AppColors.clr2388FF.withOpacity(0.20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OtherInfo {
  final String image;
  final String title;
  final VoidCallback onTap;

  OtherInfo({required this.image, required this.title, required this.onTap});
}
