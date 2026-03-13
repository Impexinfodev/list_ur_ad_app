import 'package:flutter/material.dart';
import 'package:list_ur_add/common_widgets/custom_dashboard_appbar.dart';
import 'package:list_ur_add/common_widgets/custom_drawer.dart';
import 'package:list_ur_add/common_widgets/fab_bottom_appbar_item.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/modules/dashboard/provider/dashboard_provider.dart';
import 'package:list_ur_add/modules/home/provider/home_provider.dart';
import 'package:list_ur_add/modules/notifications/provider/notification_provider.dart';
import 'package:list_ur_add/modules/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  final int index;
  final String? userId;

  const DashboardView({super.key, required this.index, this.userId});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<DashboardProvider>();
      final profileProvider = context.read<ProfileProvider>();
      final homeProvider = context.read<HomeProvider>();
      provider.onItemTapped(widget.index);
      provider.fetchCategories();
      profileProvider.fetchProfile();
      homeProvider.fetchAds(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        final notificationProvider = context.watch<NotificationProvider>();

        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Scaffold(
              appBar: provider.selectedIndex == 0 ? CustomDashboardAppBar(scaffoldKey: scaffoldKey) : null,
              drawer: provider.selectedIndex == 0 ? CustomDrawer() : null,
              key: scaffoldKey,
              backgroundColor: AppColors.clrF7F7F7,
              resizeToAvoidBottomInset: false,
              body: provider.pages.isNotEmpty
                  ? provider.pages[provider.selectedIndex]
                  : const Center(child: Text("No pages defined")),
              bottomNavigationBar: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FABBottomAppBar(
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.clr2388FF,
                      iconSize: 22,
                      height: 60,
                      items: [
                        FABBottomAppBarItem(image: AppIcons.homeIc, text: 'Home'),
                        FABBottomAppBarItem(image: AppIcons.commentIc, text: 'Inbox'),
                        FABBottomAppBarItem(image: AppIcons.marketIc, text: 'Market'),
                        FABBottomAppBarItem(
                          image: AppIcons.notificationIc,
                          text: 'Notification',
                          badgeCount: notificationProvider.unreadCount,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
