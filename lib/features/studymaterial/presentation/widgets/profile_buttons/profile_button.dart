import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.mainText,
      this.subText,
      required this.iconPath,
      required this.onTap,
      this.mainTextColor = const Color(StudyPortalConstants.spRoyalBlue)});

  final String mainText;
  final String? subText;
  final Color mainTextColor;
  final String iconPath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 76.h,
        width: 358.w,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(iconPath, width: 32.w, height: 32.h),
            SizedBox(
              width: 16.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainText,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: mainTextColor),
                ),
                subText != null
                    ? Text(
                        subText!,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                const Color(StudyPortalConstants.spFontGrey)),
                      )
                    : const SizedBox(
                        height: 0,
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
