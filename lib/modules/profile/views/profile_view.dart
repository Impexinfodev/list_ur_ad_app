import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/common_widgets/custom_button.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/constant/app_images.dart';
import 'package:list_ur_add/modules/home/provider/home_provider.dart';
import 'package:list_ur_add/modules/profile/provider/profile_provider.dart';
import 'package:list_ur_add/modules/profile/views/bookmark_view.dart';
import 'package:list_ur_add/modules/profile/views/draft_ads_view.dart';
import 'package:list_ur_add/modules/profile/views/likes_view.dart';
import 'package:list_ur_add/modules/profile/views/my_ads_view.dart';
import 'package:list_ur_add/service/api_logs.dart';
import 'package:list_ur_add/widgets/profile_widget/edit_profile_sheet.dart';
import 'package:list_ur_add/widgets/profile_widget/slanted_indicator.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _controller;
  late Animation<double> indicatorAnim;

  int previousIndex = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileProvider>().fetchProfile();
      context.read<HomeProvider>().fetchLikes();
    });
    Provider.of<ProfileProvider>(context, listen: false).getSuggestions();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 420));
    indicatorAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.08).chain(CurveTween(curve: Curves.easeOut)), weight: 60),

      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
    ]).animate(_controller);
    _controller.value = 1.0;
  }

  void _onTabTap(int index) {
    if (index == selectedIndex) return;

    previousIndex = selectedIndex;
    selectedIndex = index;

    _controller.forward(from: 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        final cover = provider.profileModel?.data?.coverUrl;
        final avatar = provider.profileModel?.data?.avatarUrl;
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        SafeArea(
                          child: SizedBox(
                            height: 165.h,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                (cover ?? "").isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: cover!,
                                        fit: BoxFit.cover,
                                        height: 120.h,
                                        width: double.infinity,
                                        placeholder: (context, url) => Container(color: Colors.grey.shade200),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(AppImages.profileBannerImg, fit: BoxFit.cover),
                                      )
                                    : Image.asset(
                                        AppImages.profileBannerImg,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                Positioned(
                                  left: 14.w,
                                  right: 14.w,
                                  child: Transform.translate(
                                    offset: Offset(0, 95.h),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 3.5.w, color: Colors.white),
                                            shape: BoxShape.circle,
                                          ),
                                          child: CircleAvatar(
                                            radius: 30.r,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                              child: (avatar ?? "").isNotEmpty
                                                  ? CachedNetworkImage(
                                                      imageUrl: avatar!,
                                                      width: 60.w,
                                                      height: 60.h,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) =>
                                                          const CircularProgressIndicator(strokeWidth: 2),
                                                      errorWidget: (context, url, error) =>
                                                          Image.asset(AppImages.profileImg, fit: BoxFit.cover),
                                                    )
                                                  : Image.asset(
                                                      AppImages.profileImg,
                                                      width: 76.w,
                                                      height: 76.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        CustomButton(
                                          buttonName: 'Edit Profile',
                                          fontSize: 12.sp,
                                          onPressed: () {
                                            EditProfileSheet.show(context);
                                          },
                                          height: 30.h,
                                          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
                                          borderColor: AppColors.clr2388FF,
                                          backgroundColor: Colors.white,
                                          textColor: AppColors.clr2388FF,
                                          borderWidth: 1.w,
                                          borderRadius: 10.r,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15.w,
                                  top: 10.h,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          padding: EdgeInsets.all(4.r),
                                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.arrow_back_ios_new,
                                            color: AppColors.clr2388FF,
                                            size: 15.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        'Profile',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontFamily: AppFonts.medium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.profileModel?.data?.fullName ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.clr141619,
                                  fontFamily: AppFonts.bold,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "@${provider.profileModel?.data?.username?.toLowerCase() ?? ''}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.clr687684,
                                  fontFamily: AppFonts.regular,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Professional ${provider.profileModel?.data?.profession ?? 'Untitled'}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.clr141619,
                                  fontFamily: AppFonts.regular,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Image.asset(AppIcons.linkIc, height: 13.h, width: 13.w, fit: BoxFit.contain),
                                  SizedBox(width: 4.w),
                                  Text(
                                    provider.profileModel?.data?.website ?? 'Untitled',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.clr2388FF,
                                      fontFamily: AppFonts.regular,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Image.asset(AppIcons.calenderIc, height: 13.h, width: 13.w, fit: BoxFit.contain),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Joined September 2025',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.clr687684,
                                      fontFamily: AppFonts.regular,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 12.sp, fontFamily: AppFonts.regular),
                                      children: [
                                        TextSpan(
                                          text: "${provider.profileModel?.data?.followingCount ?? '217'} ",
                                          style: TextStyle(color: AppColors.clr141619),
                                        ),
                                        TextSpan(
                                          text: 'Following',
                                          style: TextStyle(color: AppColors.clr687684),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 11.w),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 14.sp, fontFamily: AppFonts.regular),
                                      children: [
                                        TextSpan(
                                          text: "${provider.profileModel?.data?.followersCount ?? '217'} ",
                                          style: TextStyle(color: AppColors.clr141619),
                                        ),
                                        TextSpan(
                                          text: 'Followers',
                                          style: TextStyle(color: AppColors.clr687684),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.h),
                              provider.suggestionsList.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Discover People',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: AppColors.clr2388FF,
                                            fontFamily: AppFonts.semibold,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        SizedBox(
                                          height: 170.h,
                                          child: ListView.builder(
                                            itemCount: provider.suggestionsList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context, int index) {
                                              final suggestions = provider.suggestionsList[index];

                                              return Stack(
                                                children: [
                                                  Container(
                                                    width: 125.w,
                                                    height: 160.h,
                                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                                                    margin: EdgeInsets.only(
                                                      right: 7.w,
                                                      top: 5.h,
                                                      bottom: 5.h,
                                                      left: 2.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10.r),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors.clr2388FF.withOpacity(0.20),
                                                          blurRadius: 6,
                                                          spreadRadius: 1,
                                                          offset: const Offset(0, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30.r,
                                                          backgroundColor: Colors.white,
                                                          child: ClipOval(
                                                            child: (avatar ?? "").isNotEmpty
                                                                ? CachedNetworkImage(
                                                                    imageUrl: suggestions.avatarUrl ?? '',
                                                                    width: 60.w,
                                                                    height: 60.h,
                                                                    fit: BoxFit.cover,
                                                                    placeholder: (context, url) =>
                                                                        const CircularProgressIndicator(strokeWidth: 2),
                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                      AppImages.profileImg,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  )
                                                                : Image.asset(
                                                                    AppImages.profileImg,
                                                                    width: 76.w,
                                                                    height: 76.h,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 6.h),
                                                        Text(
                                                          (suggestions.fullName != null &&
                                                                  suggestions.fullName!.isNotEmpty)
                                                              ? suggestions.fullName!.split(' ').first
                                                              : '',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: AppColors.clr141619,
                                                            letterSpacing: -0.1,
                                                            fontFamily: AppFonts.semibold,
                                                            fontWeight: FontWeight.w500,
                                                            height: 1.1,
                                                          ),
                                                        ),
                                                        Text(
                                                          suggestions.username ?? '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            letterSpacing: -0.1,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.clr687684,
                                                            fontFamily: AppFonts.regular,
                                                            height: 1.1,
                                                          ),
                                                        ),
                                                        SizedBox(height: 15.h),
                                                        CustomButton(
                                                          buttonName: 'Follow',
                                                          fontSize: 13.sp,
                                                          onPressed: () {},
                                                          height: 28.h,
                                                          borderRadius: 8.r,
                                                          padding: EdgeInsets.symmetric(vertical: 1.h),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 12.h,
                                                    right: 14.w,
                                                    child: InkWell(
                                                      onTap: () {
                                                        provider.removeSuggestion(index);
                                                      },
                                                      child: Image.asset(
                                                        AppIcons.crossIc,
                                                        height: 15.h,
                                                        width: 15.w,
                                                        fit: BoxFit.fill,
                                                        color: AppColors.clr687684,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    clipBehavior: Clip.none,
                    elevation: 1,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    toolbarHeight: 0,
                    surfaceTintColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(45.h),
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.clr90989B.withOpacity(0.4), width: 0.5)),
                        ),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            final tabWidth = MediaQuery.of(context).size.width / 4;

                            return Stack(
                              children: [
                                Transform.translate(
                                  offset: Offset(
                                    tabWidth * (previousIndex + (selectedIndex - previousIndex) * indicatorAnim.value),
                                    0,
                                  ),
                                  child: SizedBox(
                                    width: tabWidth,
                                    height: 45.h,
                                    child: Image.asset(AppImages.tabBarBackImg, fit: BoxFit.fill),
                                  ),
                                ),

                                Row(
                                  children: List.generate(4, (index) {
                                    final isSelected = index == selectedIndex;

                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () => _onTabTap(index),
                                        child: Transform.translate(
                                          offset: Offset(0, -3.h),
                                          child: Container(
                                            height: 45.h,
                                            alignment: Alignment.center,
                                            child: Text(
                                              ["My Ads", "Bookmark", "Draft Ads", "Likes"][index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppFonts.medium,
                                                color: isSelected ? Colors.white : AppColors.clr687684,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                height: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: IndexedStack(
                index: selectedIndex,
                children: const [MyAdsView(), BookmarkView(), DraftAdsView(), LikesView()],
              ),
            ),
          ),
        );
      },
    );
  }
}
