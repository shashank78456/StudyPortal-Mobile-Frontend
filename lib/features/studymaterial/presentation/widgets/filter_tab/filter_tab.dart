import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/core/theme/constants.dart';

class FilterTab extends StatelessWidget {
  const FilterTab({
    required this.title,
    super.key,
    required int selectedIndex,
    this.tabBar = true,
    required int constraintIndex,
  })  : _selectedIndex = selectedIndex,
        _constraintIndex = constraintIndex;

  final int _selectedIndex;
  final int _constraintIndex;
  final String title;
  final bool tabBar;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: (_selectedIndex == _constraintIndex)
            ? const Color.fromRGBO(38, 48, 83, 1.0)
            : Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: const Color(StudyPortalConstants.spStrokeGrey),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.all(3.r),
      margin: EdgeInsets.only(left: 4.w),
      constraints: BoxConstraints(minWidth: 36.r, maxWidth: 100.r),
      height: 36.h,
      alignment: Alignment.center,
      child: Text(
        style: !tabBar
            ? TextStyle(
                color: _selectedIndex == _constraintIndex
                    ? Colors.white
                    : const Color(StudyPortalConstants.spRoyalBlue))
            : const TextStyle(),
        title,
      ),
    );
  }
}
