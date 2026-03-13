import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/constant/app_fonts.dart';
import 'package:list_ur_add/constant/app_icons.dart';
import 'package:list_ur_add/modules/ad/model/ad_layout_type.dart';
import 'package:list_ur_add/modules/home/provider/home_provider.dart';
import 'package:list_ur_add/service/api_logs.dart';
import 'package:list_ur_add/widgets/ad_widget/text_post_layout.dart';
import 'package:list_ur_add/widgets/home_widget/action_icon.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPostWidget extends StatefulWidget {
  final AdLayoutType? layoutType;
  final String? profileName;
  final String? profileImage;
  final bool? isVerified;
  final bool? showFollow;
  final String? postImage;
  final String? jobTitle;
  final String? location;
  final String? ctc;
  final String? experience;
  final String? description;
  final String? email;
  final int? likes;
  final bool? isLiked;
  final Function()? onLikeTap;
  final int? comments;
  final int? calls;
  final String? analysis;
  final bool? isBookmarked;
  final Function()? onBookmarkTap;
  final bool? isShared;
  final Function()? onShareTap;
  final bool? isTranslated;
  final bool? isSponsored;
  final String? adId;

  const JobPostWidget({
    super.key,
    this.layoutType,
    this.profileName,
    this.profileImage,
    this.isVerified,
    this.showFollow,
    this.postImage,
    this.jobTitle,
    this.location,
    this.ctc,
    this.experience,
    this.description,
    this.email,
    this.likes,
    this.isLiked,
    this.onLikeTap,
    this.comments,
    this.calls,
    this.analysis,
    this.isBookmarked,
    this.onBookmarkTap,
    this.isShared,
    this.onShareTap,
    this.isTranslated,
    this.isSponsored,
    this.adId,
  });

  @override
  State<JobPostWidget> createState() => _JobPostWidgetState();
}

class _JobPostWidgetState extends State<JobPostWidget> {
  bool isTranslated = false;
  bool isCommentSelected = false;
  bool isCommentBoxVisible = false;

  @override
  Widget build(BuildContext context) {
    if (widget.layoutType == AdLayoutType.textOnly ||
        widget.layoutType == AdLayoutType.yellowText ||
        widget.layoutType == AdLayoutType.pinkText) {
      return TextPostLayout(
        backgroundColor: getTextBg(widget.layoutType),
        text: widget.description ?? '',
        highlightText: widget.email,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35.r),
                child: widget.profileImage != null && widget.profileImage!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.profileImage!,
                        height: 35.h,
                        width: 35.h,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Image.asset(AppIcons.profileIc, height: 35.h, width: 35.h, fit: BoxFit.cover),
                        errorWidget: (context, url, error) =>
                            Image.asset(AppIcons.profileIc, height: 35.h, width: 35.h, fit: BoxFit.cover),
                      )
                    : Image.asset(AppIcons.profileIc, height: 35.h, width: 35.h, fit: BoxFit.cover),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.profileName != null || (widget.isVerified == true) || (widget.showFollow == true))
                        Row(
                          children: [
                            Text(
                              widget.profileName!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: AppFonts.semibold,
                                color: AppColors.clr141619,
                              ),
                            ),
                            if (widget.isVerified == true) ...[
                              SizedBox(width: 6.w),
                              Image.asset(AppIcons.verifyIc, height: 15.h, width: 15.w),
                            ],
                            SizedBox(width: 8.w),
                            Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: AppFonts.semibold,
                                color: AppColors.clr2388FF,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Sponsored',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: AppFonts.semibold,
                                color: AppColors.clr141619,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Image.asset(AppIcons.moreIc, height: 15.h, width: 15.w),
                            SizedBox(width: 15.w),
                          ],
                        ),
                      SizedBox(height: 6.h),
                      buildLayoutContent(),
                      if (_hasAnyAction()) ...[SizedBox(height: 10.h), buildActionRow()],
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isCommentBoxVisible) ...[SizedBox(height: 10.h), _buildCommentInputBox()],
          Divider(color: AppColors.clrCED5DC),
        ],
      ),
    );
  }

  Color getTextBg(AdLayoutType? type) {
    switch (type) {
      case AdLayoutType.yellowText:
        return AppColors.clrE3F300.withOpacity(0.50);
      case AdLayoutType.pinkText:
        return AppColors.clrFF81E4.withOpacity(0.50);
      default:
        return Colors.white;
    }
  }

  bool _hasAnyAction() {
    return (widget.likes ?? 0) > 0 ||
        (widget.comments ?? 0) > 0 ||
        (widget.calls ?? 0) > 0 ||
        (widget.analysis != null && widget.analysis!.isNotEmpty) ||
        (widget.isBookmarked == true) ||
        (widget.isShared == true) ||
        (widget.isTranslated == true);
  }

  Widget buildLayoutContent() {
    switch (widget.layoutType) {
      case AdLayoutType.imageOnly:
        return buildImage();
      case AdLayoutType.textOnly:
      case AdLayoutType.yellowText:
      case AdLayoutType.pinkText:
        return TextPostLayout(
          backgroundColor: getTextBg(widget.layoutType),
          text: widget.description ?? '',
          highlightText: widget.email,
        );
      case AdLayoutType.imageWithText:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(),
            SizedBox(height: 6.h),
            TextPostLayout(
              backgroundColor: getTextBg(widget.layoutType),
              text: widget.description ?? '',
              highlightText: widget.email,
            ),
          ],
        );
      case AdLayoutType.textWithImage:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPostLayout(
              backgroundColor: getTextBg(widget.layoutType),
              text: widget.description ?? '',
              highlightText: widget.email,
            ),
            SizedBox(height: 6.h),
            buildImage(),
          ],
        );

      case AdLayoutType.imageWithTextLayoutLeft:
        return _sideBySideLayout(leftImage: true);

      case AdLayoutType.imageWithTextLayoutRight:
        return _sideBySideLayout(leftImage: false);

      default:
        return TextPostLayout(
          backgroundColor: getTextBg(widget.layoutType),
          text: widget.description ?? '',
          highlightText: widget.email,
        );
    }
  }

  Widget _sideBySideLayout({required bool leftImage}) {
    final imageWidth = 154.w;
    final imageHeight = 178.h;
    final spacing = 6.w;

    final textStyle = TextStyle(fontSize: 14.sp, fontFamily: AppFonts.regular, height: 1.4, color: AppColors.clr141619);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableTextWidth = constraints.maxWidth - imageWidth - spacing;
        final fullText = widget.description ?? '';
        final sideText = _getFittingText(
          text: fullText,
          style: textStyle,
          maxWidth: availableTextWidth,
          maxHeight: imageHeight,
        );
        final belowText = fullText.substring(sideText.length);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: leftImage
                  ? [
                      SizedBox(width: imageWidth, height: imageHeight, child: buildImage()),
                      SizedBox(width: spacing),
                      Expanded(child: Text(sideText, style: textStyle)),
                    ]
                  : [
                      Expanded(child: Text(sideText, style: textStyle)),
                      SizedBox(width: spacing),
                      SizedBox(width: imageWidth, height: imageHeight, child: buildImage()),
                    ],
            ),
            if (belowText.isNotEmpty) ...[SizedBox(height: 4.h), Text(belowText, style: textStyle)],
          ],
        );
      },
    );
  }

  String _getFittingText({
    required String text,
    required TextStyle style,
    required double maxWidth,
    required double maxHeight,
  }) {
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: null);
    int low = 0, high = text.length;

    while (low < high) {
      final mid = (low + high + 1) ~/ 2;
      tp.text = TextSpan(text: text.substring(0, mid), style: style);
      tp.layout(maxWidth: maxWidth);

      if (tp.height <= maxHeight) {
        low = mid;
      } else {
        high = mid - 1;
      }
    }

    return text.substring(0, low);
  }

  Widget buildImage() {
    if (widget.postImage == null) return const SizedBox();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Image.asset(widget.postImage!, height: 200.h, width: double.infinity, fit: BoxFit.cover),
    );
  }

  Widget buildActionRow() {
    return Row(
      children:
          [
                GestureDetector(
                  onTap: widget.onLikeTap,
                  child: ActionIcon(
                    icon: (widget.isLiked ?? false) ? AppIcons.heartFilledIc : AppIcons.heartIc,
                    text: (widget.likes ?? 0).toString(),
                  ),
                ),

                GestureDetector(
                  onTap: onCommentTap,
                  child: ActionIcon(
                    icon: isCommentSelected ? AppIcons.commentSelectedIc : AppIcons.commentIc,
                    text: widget.comments.toString(),
                  ),
                ),

                GestureDetector(
                  onTap: onCallTap,
                  child: const ActionIcon(icon: AppIcons.callIc),
                ),

                GestureDetector(
                  onTap: onCallTap,
                  child: ActionIcon(icon: AppIcons.analysisIc, text: widget.calls.toString()),
                ),

                GestureDetector(
                  onTap: widget.onBookmarkTap,
                  child: ActionIcon(icon: widget.isBookmarked == true ? AppIcons.saveBookmarkIc : AppIcons.bookmarkIc),
                ),

                GestureDetector(
                  onTap: () async {
                    final shareUrl = await widget.onShareTap?.call();
                    if (shareUrl != null && shareUrl.isNotEmpty) {
                      await Share.share('Check out this ad: $shareUrl');
                    }
                  },
                  child: const ActionIcon(icon: AppIcons.shareIc),
                ),

                GestureDetector(
                  onTap: onTranslateTap,
                  child: ActionIcon(icon: isTranslated ? AppIcons.translateSelectedIc : AppIcons.translateSelectedIc),
                ),
              ]
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: e,
                ),
              )
              .toList(),
    );
  }

  Widget _buildCommentInputBox() {
    final TextEditingController controller = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Image.asset(AppIcons.profileIc, height: 36.h, width: 36.w, fit: BoxFit.cover),
            SizedBox(width: 6.w),
            Image.asset(AppIcons.gallaryIc, height: 22.h, width: 22.w),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.clr0067FF),
              child: Icon(Icons.add, size: 18.sp, color: Colors.white),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(color: AppColors.clrF7F7F7, borderRadius: BorderRadius.circular(8.r)),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'I would like to connect with you, Can we make a on call Discussion?',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Image.asset(AppIcons.sendChatIc, height: 24.h, width: 24.w, fit: BoxFit.contain)],
            ),
          ],
        ),
      ),
    );
  }

  void onTranslateTap() {
    setState(() {
      isTranslated = !isTranslated;
    });
  }

  Future<void> onCallTap() async {
    const phone = 'tel:+919999999999';
    if (await canLaunchUrl(Uri.parse(phone))) {
      await launchUrl(Uri.parse(phone));
    }
  }

  void onCommentTap() {
    setState(() {
      isCommentBoxVisible = !isCommentBoxVisible;
      isCommentSelected = !isCommentSelected;
    });
  }
}
