import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/core/theme/constants.dart';

class FileScrollSection extends StatelessWidget {
  const FileScrollSection({
    super.key,
    required this.size,
    required this.fileTiles,
  });

  final Size size;
  final List<Widget> fileTiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12).r,
      margin: const EdgeInsets.only(bottom: 20).h,
      width: size.width.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: const Color(StudyPortalConstants.spStrokeGrey)),
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Column(
        children: [
          for (int index = 0; index < fileTiles.length; index++)
            Column(
              children: [
                fileTiles[index],
                SizedBox(
                  height: 13.h,
                ),
              ],
            )
        ],
      ),
    );
  }
}
