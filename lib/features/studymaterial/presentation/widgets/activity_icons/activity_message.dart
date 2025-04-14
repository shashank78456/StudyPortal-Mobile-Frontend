import 'package:flutter/material.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/activity_status_enum.dart';
import 'package:flutter_svg/svg.dart';

class ActivityMessage extends StatelessWidget {
  final ActivityStatus status;
  const ActivityMessage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == ActivityStatus.pending) {
      return SvgPicture.asset("lib/core/svgs/pending_message.svg");
    } else if (status == ActivityStatus.approved) {
      return SvgPicture.asset("lib/core/svgs/approved_message.svg");
    } else if (status == ActivityStatus.rejected) {
      return SvgPicture.asset("lib/core/svgs/rejected_message.svg");
    } else {
      return SvgPicture.asset("lib/core/svgs/pending_message.svg");
    }
  }
}
