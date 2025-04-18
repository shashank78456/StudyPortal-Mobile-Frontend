import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/profile_page/components/your_contributions.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/profile_page/components/action_buttons.dart';
import 'package:studyportal/main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Data that needs to be fecthed from data base
  // Name
  // Number of uploads
  // Number of requests
  // Department
  // Email

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  height: 140.h,
                  width: 360.w,
                  "lib/core/svgs/profile_background.svg",
                  fit: BoxFit.fill,
                ),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 140.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              'lib/features/studymaterial/data/pre_integration/kambli.jpg',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Angad Kambli",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Department of Computer Science",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "a_kambli@cs.iitr.ac.in",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(StudyPortalConstants.spGrey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  YourContributions(size: size, uploads: 132, requests: 123),
                  SizedBox(
                    height: 20.h,
                  ),
                  const ActionButtons(),
                  SizedBox(
                    height: 20.h,
                  ),
                  SvgPicture.asset("lib/core/svgs/sdslabs.svg"),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
