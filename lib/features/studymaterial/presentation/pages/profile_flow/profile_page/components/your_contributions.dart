import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';

class YourContributions extends StatelessWidget {
  const YourContributions(
      {super.key,
      required this.size,
      required this.uploads,
      required this.requests});

  final Size size;
  final int uploads;
  final int requests;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216.h,
      width: size.width,
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 0).r,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: const Color(StudyPortalConstants.spStrokeGrey)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "lib/core/svgs/your_contribution.svg",
                width: 16,
                height: 16,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                "Your contribution",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Stack(
            children: [
              SvgPicture.asset(
                height: 80.h,
                "lib/core/svgs/file_uploaded.svg",
                // fit: BoxFit.fill,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 80.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uploads.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "Files you uploaded",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Stack(
            children: [
              SvgPicture.asset(
                height: 80.h,
                "lib/core/svgs/file_requested.svg",
                // fit: BoxFit.,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 80.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      requests.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "Files you requested",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
