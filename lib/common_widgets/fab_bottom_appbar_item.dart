import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/modules/dashboard/provider/dashboard_provider.dart';
import 'package:list_ur_add/modules/notifications/provider/notification_provider.dart';
import 'package:list_ur_add/widgets/ad_widget/ad_terms_sheet.dart';
import 'package:provider/provider.dart';

class FABBottomAppBarItem {
  final String image;
  final String text;
  final int badgeCount;

  FABBottomAppBarItem({required this.image, required this.text, this.badgeCount = 0});
}

class FABBottomAppBar extends StatelessWidget {
  final List<FABBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;

  const FABBottomAppBar({
    super.key,
    required this.items,
    this.height = 50.0,
    this.iconSize = 20.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return BottomAppBar(
          surfaceTintColor: backgroundColor,
          color: Colors.white,
          shadowColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          shape: notchedShape,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(items.length + 1, (index) {
              if (index == items.length ~/ 2) {
                return Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Transform.translate(
                        offset: const Offset(0, -6),
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: AppColors.clr2388FF,
                          onPressed: () {
                            AdTermsSheet.show(context);
                          },
                          child: const Icon(Icons.add, color: Colors.white, size: 40),
                        ),
                      ),
                    ),
                  ),
                );
              }
              final itemIndex = index > items.length ~/ 2 ? index - 1 : index;
              return _buildTabItem(
                context: context,
                provider: provider,
                item: items[itemIndex],
                index: itemIndex,
                isSelected: provider.selectedIndex == itemIndex,
              );
            }),
          ),
        );
      },
    );
    ();
  }

  Widget _buildTabItem({
    required BuildContext context,
    required DashboardProvider provider,
    required FABBottomAppBarItem item,
    required int index,
    required bool isSelected,
  }) {
    Color? color = isSelected ? selectedColor : this.color;

    return Expanded(
      child: SizedBox(
        height: height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () async {
              provider.onItemTapped(index);
              if (item.text.toLowerCase() == 'notification') {
                final notificationProvider = Provider.of<NotificationProvider>(
                  context,
                  listen: false,
                );
                await notificationProvider.readAllNotifications();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(item.image, height: iconSize.h, width: iconSize.w, color: color),
                    if (item.badgeCount > 0)
                      Positioned(
                        right: -6,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Center(
                            child: Text(
                              item.badgeCount > 9 ? "9+" : item.badgeCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  item.text,
                  style: TextStyle(
                    color: isSelected ? AppColors.clr2388FF : AppColors.clr687684,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
