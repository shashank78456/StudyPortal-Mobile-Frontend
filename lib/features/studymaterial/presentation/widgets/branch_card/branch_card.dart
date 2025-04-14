import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/domain/entities/branch.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/explore_flow/course_list_page/course_list_page.dart';
import 'package:studyportal/features/studymaterial/presentation/utils/searchable.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/bookmarked_pin/pin_active.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/bookmarked_pin/pin_inactive.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/pin_enum.dart';

class BranchCard extends StatelessWidget implements Searchable {
  final Pin pin;
  final VoidCallback? onTap;
  final Branch branch;

  const BranchCard(
      {super.key, required this.branch, required this.pin, this.onTap});
  @override
  String get title => branch.name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap ??
      onTap: onTap ??
          () {
            Navigator.of(context).push(
              CourseListPage.route(branch),
            );
          },
      child: Container(
        width: 160.w,
        height: 160.h,
        padding: const EdgeInsets.only(bottom: 12).w,
        decoration: BoxDecoration(
          color: Color(StudyPortalConstants.spColorList[branch.id % 4]),
          borderRadius: BorderRadius.circular(12).w,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12).w,
          child: Column(
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 1,
                    child: SvgPicture.asset(
                      "lib/core/svgs/card_design.svg",
                      colorFilter: const ColorFilter.mode(
                          Colors.white38, BlendMode.srcIn),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      margin: const EdgeInsets.all(10).w,
                      child: (pin == Pin.inactive)
                          ? const PinInactive()
                          : (pin == Pin.active)
                              ? const SizedBox(child: PinActive())
                              : const Opacity(opacity: 0),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16).w,
                width: double.infinity.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      branch.name,
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      branch.department,
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
