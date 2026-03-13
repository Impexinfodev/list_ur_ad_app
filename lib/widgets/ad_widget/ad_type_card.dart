import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/common_widgets/custom_button.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/modules/ad/model/ad_layout_type.dart';

class AdTypeCard extends StatelessWidget {
  final AdTypeModel ad;

  const AdTypeCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(color: AppColors.clrCED5DC.withOpacity(0.2), blurRadius: 30)],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.clrF4F5F8,
          border: Border.all(color: AppColors.clrE3EAFF, width: 1.w),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [BoxShadow(color: AppColors.clrCED5DC.withOpacity(0.2), blurRadius: 30)],
        ),
        child: Column(
          children: [
            _buildAdPreview(),
            SizedBox(height: 12.h),
            CustomButton(buttonName: '${ad.price} Select', onPressed: () {}, backgroundColor: AppColors.clr7EB9FF),
          ],
        ),
      ),
    );
  }

  Widget _buildAdPreview() {
    switch (ad.layoutType) {
      case AdLayoutType.textOnly:
        return Column(
          children: [
            Text(
              ad.title ?? '',
              style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
            ),
            SizedBox(height: 8.h),
            _textLines(),
          ],
        );

      case AdLayoutType.yellowText:
        return Column(
          children: [
            Text(
              ad.title ?? '',
              style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: AppColors.clrF1F980, borderRadius: BorderRadius.circular(6.r)),
              child: _clrTextLines(),
            ),
          ],
        );

      case AdLayoutType.pinkText:
        return Column(
          children: [
            Text(
              ad.title ?? '',
              style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: AppColors.clrFFC0F2, borderRadius: BorderRadius.circular(6.r)),
              child: _clrTextLines(),
            ),
          ],
        );

      case AdLayoutType.imageOnly:
        return _imageBox();

      case AdLayoutType.imageWithText:
        return Column(
          children: [
            _imageBox(),
            SizedBox(height: 8.w),
            _textLines(lineCount: 2, lineWidths: [0.8, 0.6]),
          ],
        );

      case AdLayoutType.textWithImage:
        return Column(
          children: [
            Row(
              children: [
                Text(
                  ad.title ?? '',
                  style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: _textLines(
                    lineCount: 2,
                    lineWidths: [0.8, 0.9],
                    lineAlignments: [Alignment.centerRight, Alignment.centerRight],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            _imageBox(),
          ],
        );

      case AdLayoutType.imageWithTextLayoutRight:
        return Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    ad.title ?? '',
                    style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
                  ),
                  SizedBox(height: 8.h),
                  _textLines(
                    lineCount: 6,
                    lineWidths: [0.6, 0.9, 0.9, 0.9, 0.9, 0.9],
                    lineAlignments: [
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(child: _imageBox(height: 110.h)),
          ],
        );

      case AdLayoutType.imageWithTextLayoutLeft:
        return Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(child: _imageBox(height: 110.h)),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    ad.title ?? '',
                    style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
                  ),
                  SizedBox(height: 8.h),
                  _textLines(
                    lineCount: 6,
                    lineWidths: [0.6, 0.9, 0.9, 0.9, 0.9, 0.9],
                    lineAlignments: [
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                      Alignment.topRight,
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _textLines({int lineCount = 4, List<double>? lineWidths, List<Alignment>? lineAlignments}) {
    return Column(
      children: List.generate(lineCount, (index) {
        final double widthFactor = lineWidths != null && index < lineWidths.length ? lineWidths[index] : 1.0;

        final Alignment alignment = lineAlignments != null && index < lineAlignments.length
            ? lineAlignments[index]
            : Alignment.centerLeft;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          height: 6.h,
          width: double.infinity,
          child: FractionallySizedBox(
            alignment: alignment,
            widthFactor: widthFactor,
            child: Container(
              decoration: BoxDecoration(color: AppColors.clrD7E3F9, borderRadius: BorderRadius.circular(100.r)),
            ),
          ),
        );
      }),
    );
  }

  Widget _clrTextLines() {
    return Column(
      children: List.generate(
        4,
        (index) => Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          height: 6.h,
          decoration: BoxDecoration(color: AppColors.clr8D97B7, borderRadius: BorderRadius.circular(100.r)),
        ),
      ),
    );
  }

  Widget _imageBox({double? height}) {
    final bool showTitle = ad.layoutType == AdLayoutType.imageOnly || ad.layoutType == AdLayoutType.imageWithText;

    return Container(
      padding: EdgeInsets.all(6.w),
      width: double.infinity,
      height: height ?? 80.h,
      decoration: BoxDecoration(color: AppColors.clrCFE4FD, borderRadius: BorderRadius.circular(4.r)),
      child: showTitle
          ? Align(
              alignment: Alignment.topLeft,
              child: Text(
                ad.title ?? '',
                style: TextStyle(color: AppColors.clr1289FF, fontSize: 13.sp, fontFamily: AppFonts.medium),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
