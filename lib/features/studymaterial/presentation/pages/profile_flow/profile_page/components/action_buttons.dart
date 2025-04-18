import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/profile_buttons/profile_button.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/activity_page/activity_page.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/request_page/request_page.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/upload_page/upload_page.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 306.h,
      width: 358.w,
      // padding: const EdgeInsets.all(12).r,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: const Color(StudyPortalConstants.spStrokeGrey)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfileButton(
            mainText: "Upload Files",
            subText: "Have something to share?",
            iconPath: "lib/core/svgs/upload.svg",
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UploadPage()));
            },
          ),
          ProfileButton(
            mainText: "Request Files",
            subText: "Can't find something?",
            iconPath: "lib/core/svgs/request.svg",
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RequestPage()));
            },
          ),
          ProfileButton(
            mainText: "Activity",
            subText: "Status of uploads and requests",
            iconPath: "lib/core/svgs/activity.svg",
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ActivityPage()));
            },
          ),
          ProfileButton(
              mainTextColor: Colors.pinkAccent,
              mainText: "Logout",
              iconPath: "lib/core/svgs/logout.svg",
              onTap: () {}),
          // Container(
          //   padding: const EdgeInsets.all(12).r,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       SvgPicture.asset("lib/core/svgs/logout.svg",
          //           width: 32.w, height: 32.h),
          //       SizedBox(
          //         width: 16.w,
          //       ),
          //       Text("Logout",
          //           style: TextStyle(
          //               fontSize: 20.sp,
          //               fontWeight: FontWeight.w500,
          //               color: Colors.pinkAccent))
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
