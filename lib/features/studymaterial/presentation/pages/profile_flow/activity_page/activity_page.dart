import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/activity_card/activity_card.dart';
import 'package:studyportal/features/studymaterial/data/pre_integration/hardcoded_stuff.dart';

class ActivityPage extends StatelessWidget {
  ActivityPage({super.key});
  static get route => MaterialPageRoute(builder: (context) => ActivityPage());
  final List<Activity> activities = HardCodedConstants.activities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Activity",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (int index = 0; index < activities.length; index++)
                    Column(
                      children: [
                        ActivityCard(activity: activities[index]),
                        SizedBox(
                          height: 6.h,
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                ])),
      ),
    );
  }
}
