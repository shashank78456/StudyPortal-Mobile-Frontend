import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/activity_status_enum.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/file_type_enum.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_icons/file_icons.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/activity_icons/activity_icon.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/activity_icons/activity_message.dart';

class Activity {
  final String title;
  final String courseCode;
  final DateTime date;
  final ActivityStatus status;
  final String message;
  final FileType fileType;

  const Activity({
    required this.title,
    required this.courseCode,
    required this.date,
    required this.status,
    required this.message,
    required this.fileType,
  });
}

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: 360.w,
      height: 118.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top:
                    BorderSide(color: Color(StudyPortalConstants.spStrokeGrey)),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FileIcons(fileType: activity.fileType),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              activity.courseCode,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "${activity.date.day.toString().padLeft(2, '0')} ${_getMonth(activity.date.month)} ${activity.date.year.toString().substring(2)}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                ActivityMessage(status: activity.status),
              ],
            ),
          ),

          // Divider
          Container(
            width: size.width,
            height: 2.h,
            color: const Color(StudyPortalConstants.spStrokeGrey),
          ),

          // Bottom Message Row
          Container(
            padding: EdgeInsets.all(12.r),
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom:
                    BorderSide(color: Color(StudyPortalConstants.spStrokeGrey)),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActivityIcon(status: activity.status),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    activity.message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
