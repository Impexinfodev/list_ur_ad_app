import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/common_widgets/custom_input_fields.dart';
import 'package:list_ur_add/widgets/home_widget/alert_sheet.dart';
import 'package:list_ur_add/widgets/home_widget/category_chip.dart';
import 'package:list_ur_add/widgets/home_widget/category_dialog.dart';
import 'package:list_ur_add/widgets/home_widget/custom_calendar_widget.dart';
import 'package:provider/provider.dart';
import 'package:list_ur_add/modules/dashboard/provider/dashboard_provider.dart';

class CustomDashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomDashboardAppBar({super.key, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => scaffoldKey.currentState!.openDrawer(),
                    child: Image.asset(
                      AppIcons.profileIc,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      leading: Image.asset(
                        AppIcons.searchIc,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      hintText: 'Search here',
                      leading1: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppIcons.googleMicIc,
                            height: 20,
                            width: 20,
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            AppIcons.googleLensIc,
                            height: 20,
                            width: 20,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(AppIcons.locationOnIc, height: 22, width: 22, fit: BoxFit.contain),
                  const SizedBox(width: 12),
                  Image.asset(
                    AppIcons.translateSelectedIc,
                    height: 22,
                    width: 22,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 11),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: CustomDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            onDateSelected: (date) {
                              debugPrint('Selected date: $date');
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.clrF1F3F7, width: 1.6),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.clr1D9BF0.withOpacity(0.10),
                            blurRadius: 6,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 8,
                              fontFamily: AppFonts.medium,
                              color: AppColors.clr687684,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            '23',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.medium,
                              color: AppColors.clr2388FF,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => AlertSheet.show(context),
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.clrF1F3F7, width: 1.6),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.clr1D9BF0.withOpacity(0.10),
                            blurRadius: 6,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Alert',
                            style: TextStyle(
                              fontSize: 8,
                              fontFamily: AppFonts.medium,
                              color: AppColors.clr687684,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Image.asset(AppIcons.bellIc, height: 16, width: 16, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: provider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.categories.length,
                              itemBuilder: (context, index) {
                                final category = provider.categories[index];

                                return Padding(
                                  padding: EdgeInsets.only(right: 6.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => CategoryDialog(
                                          categories: provider.categories
                                              .map((e) => e.name)
                                              .toList(),
                                          onSelect: (value) {
                                            final selected = provider.categories.firstWhere(
                                              (element) => element.name == value,
                                            );
                                            provider.setSelectedCategory(value);
                                            provider.fetchSubCategories(selected.id);
                                          },
                                        ),
                                      );
                                    },
                                    child: CategoryChip(
                                      title: provider.selectedCategory ?? category.name,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
