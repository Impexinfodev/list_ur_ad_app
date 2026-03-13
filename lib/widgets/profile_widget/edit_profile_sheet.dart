import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/constant/app_images.dart';
import 'package:list_ur_add/modules/profile/provider/profile_provider.dart';
import 'package:list_ur_add/util/image_picker_utils.dart';
import 'package:list_ur_add/util/media_source_picker.dart';
import 'package:provider/provider.dart';

class EditProfileSheet extends StatefulWidget {
  const EditProfileSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const EditProfileSheet(),
    );
  }

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  File? profileImage;
  File? coverImage;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final genderController = TextEditingController();
  final professionController = TextEditingController();
  final dobController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profileModel;
    nameController.text = profile?.data?.fullName ?? "";
    bioController.text = profile?.data?.bio ?? "";
    genderController.text = profile?.data?.gender ?? "";
    professionController.text = profile?.data?.profession ?? "";
    websiteController.text = profile?.data?.website ?? "";
  }

  Future<void> _pickImage({required bool isCover}) async {
    final value = await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => const MediaSourcePicker(),
    );

    if (value != null && value is ImageSource) {
      File? pickedFile = await PickImageUtility.instance(context: context).pickedFile(value);

      if (pickedFile != null) {
        setState(() {
          if (isCover) {
            coverImage = pickedFile;
          } else {
            profileImage = pickedFile;
          }
        });
      }
    }
  }

  Widget _divider() {
    return Divider(height: 1, thickness: 0.4, color: AppColors.clr90989B.withOpacity(0.60));
  }

  Widget _item(String title, TextEditingController controller, {bool isMulti = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: isMulti ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              title,
              style: TextStyle(color: AppColors.clr141619, fontFamily: AppFonts.bold, fontSize: 16.sp),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: isMulti ? null : 1,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final profileData = profileProvider.profileModel?.data;

    return FractionallySizedBox(
      heightFactor: 0.75,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.clr434445, fontSize: 14.sp, fontFamily: AppFonts.medium),
                    ),
                  ),
                  Text(
                    "Edit Profile",
                    style: TextStyle(color: AppColors.clr141619, fontSize: 16.sp, fontFamily: AppFonts.bold),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final provider = Provider.of<ProfileProvider>(context, listen: false);
                      final body = {
                        "full_name": nameController.text,
                        "bio": bioController.text,
                        "gender": genderController.text,
                        "profession": professionController.text,
                        "website": websiteController.text,
                      };
                      bool success = await provider.updateProfile(body);
                      if (success) {
                        if (profileImage != null) {
                          await provider.uploadProfileImage(profileImage!);
                          profileImage = null; // clear local file
                        }
                        if (coverImage != null) {
                          await provider.uploadCoverImage(coverImage!);
                          coverImage = null; // clear local file
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: AppColors.clr282828, fontSize: 14.sp, fontFamily: AppFonts.semibold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Cover Image
                        GestureDetector(
                          onTap: () => _pickImage(isCover: true),
                          child: Container(
                            height: 140.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: coverImage != null
                                    ? FileImage(coverImage!)
                                    : (profileData?.coverUrl != null
                                              ? NetworkImage(profileData!.coverUrl!)
                                              : AssetImage(AppImages.imageCover))
                                          as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(AppIcons.photoUploadIc, height: 40.h, width: 40.w),
                            ),
                          ),
                        ),
                        // Profile Image
                        Positioned(
                          top: 110.h,
                          left: 16.w,
                          child: GestureDetector(
                            onTap: () => _pickImage(isCover: false),
                            child: Container(
                              height: 76.h,
                              width: 76.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4.w),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: profileImage != null
                                      ? FileImage(profileImage!)
                                      : (profileData?.avatarUrl != null
                                                ? NetworkImage(profileData!.avatarUrl!)
                                                : AssetImage(AppImages.imageCover))
                                            as ImageProvider,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(color: AppColors.clr1289FF, shape: BoxShape.circle),
                                  child: Image.asset(AppIcons.photoUploadIc, height: 16.h, width: 16.w),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70.h),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 8,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final fields = [
                          {"title": "Name", "controller": nameController, "isMulti": false},
                          {"title": "Phone", "controller": phoneController, "isMulti": false},
                          {"title": "Bio", "controller": bioController, "isMulti": true},
                          {"title": "Gender", "controller": genderController, "isMulti": false},
                          {"title": "Profession", "controller": professionController, "isMulti": false},
                          {"title": "DOB", "controller": dobController, "isMulti": false},
                          {"title": "Website", "controller": websiteController, "isMulti": false},
                          {"title": "Address", "controller": addressController, "isMulti": true},
                        ];

                        final field = fields[index];

                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.clr90989B.withOpacity(0.4), width: 0.5)
                          ),
                          child: Row(
                            crossAxisAlignment: field["isMulti"] as bool
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 110.w,
                                child: Text(
                                  field["title"] as String,
                                  style: TextStyle(
                                    color: AppColors.clr141619,
                                    fontFamily: AppFonts.regular,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    color: AppColors.clr2388FF,
                                    fontFamily: AppFonts.regular,
                                    fontSize: 16.sp,
                                  ),
                                  controller: field["controller"] as TextEditingController,
                                  maxLines: (field["isMulti"] as bool) ? null : 1,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 8.w,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
