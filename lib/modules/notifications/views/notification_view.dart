import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/common_widgets/custom_app_bar.dart';
import 'package:list_ur_add/common_widgets/custom_toggle_switch.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/modules/notifications/provider/notification_provider.dart';
import 'package:list_ur_add/modules/payment/model/payment_history_model.dart';
import 'package:list_ur_add/widgets/home_widget/alert_sheet.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<NotificationProvider>(context, listen: false);
      provider.fetchNotifications();
      provider.getUnreadCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'Notification',
            goHome: true,
            widget: GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Image.asset(AppIcons.settingIc, height: 24.h, width: 24.w),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                margin: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Image.asset(AppIcons.profileIc, height: 48.h, width: 48.w, fit: BoxFit.contain),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            notification.title.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: AppFonts.medium,
                              color: AppColors.clr141619,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: AppFonts.regular,
                                color: AppColors.clr687684.withOpacity(0.90),
                              ),
                              children: [
                                TextSpan(text: notification.body.toString()),
                                TextSpan(
                                  text: "Connect Now?",
                                  style: TextStyle(
                                    fontFamily: AppFonts.regular,
                                    fontSize: 14.sp,
                                    color: AppColors.clr2388FF,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
