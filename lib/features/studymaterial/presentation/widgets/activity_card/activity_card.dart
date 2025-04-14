import 'package:flutter/material.dart';
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
        width: size.width,
        height: 128,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    top: 12, left: 12, right: 12, bottom: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          color: Color(StudyPortalConstants.spStrokeGrey))),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        FileIcons(fileType: activity.fileType),
                        const SizedBox(
                          width: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              activity.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  activity.courseCode,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  "${activity.date.day.toString().padLeft(2, '0')} ${_getMonth(activity.date.month)} ${activity.date.year.toString().substring(2)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        ActivityMessage(status: activity.status),
                      ],
                    ),
                  ],
                )),
            SizedBox(
              width: size.width,
              height: 2,
              child: Container(
                color: const Color(StudyPortalConstants.spStrokeGrey),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 12, left: 12, right: 12, bottom: 12),
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color(StudyPortalConstants.spStrokeGrey))),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ActivityIcon(status: activity.status),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      activity.message,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                )),
          ],
        ));
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
