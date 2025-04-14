import 'package:flutter/material.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/activity_status_enum.dart';
import 'package:flutter_svg/svg.dart';

class ActivityIcon extends StatelessWidget {
  final ActivityStatus status;
  const ActivityIcon({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == ActivityStatus.pending) {
      return SvgPicture.asset("lib/core/svgs/pending.svg");
    } else if (status == ActivityStatus.approved) {
      return SvgPicture.asset("lib/core/svgs/approved.svg");
    } else if (status == ActivityStatus.rejected) {
      return SvgPicture.asset("lib/core/svgs/rejected.svg");
    } else {
      return SvgPicture.asset("lib/core/svgs/pending.svg");
    }
  }
}
