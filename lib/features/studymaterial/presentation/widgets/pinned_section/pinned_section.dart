import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_pins/fetch_pins_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/branch_card/branch_card.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/more_info_button/more_info_button.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/pin_enum.dart';

class PinnedSection extends StatelessWidget {
  const PinnedSection({
    super.key,
    required this.state,
    required this.size,
    required this.onTap,
  });

  final FetchPinsState state;
  final Size size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12).r,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color(StudyPortalConstants.spStrokeGrey),
              width: 1.w),
          borderRadius: BorderRadius.circular(8)),
      width: size.width.w,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "lib/core/svgs/pin_inactive.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "Pinned",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 160.h,
            width: size.width.w,
            child: BlocBuilder<FetchPinsCubit, FetchPinsState>(
                builder: (context, state) {
              if (state is FetchPinsLoading || state is FetchPinsInitial) {
                return const Loader();
              } else if (state is FetchPinsFailure) {
                return Text(state.message);
              } else if (state is FetchPinsLoaded) {
                final List<BranchCard> pinnedCards = state.pins.map((branch) {
                  return BranchCard(
                    branch: branch,
                    pin: Pin.none,
                    onTap: () => {},
                  );
                  //add onTap
                }).toList();
                if (pinnedCards.isEmpty) {
                  return const Center(
                    child: Text("No Pins Added"),
                  );
                } else {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: pinnedCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return pinnedCards[index];
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.w,
                      );
                    },
                  );
                }
              }
              return const SizedBox.shrink();
            }),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              const Spacer(),
              MoreInfoButton(
                onTap: onTap,
                icon: SvgPicture.asset(
                    height: 11.h, width: 6.w, "lib/core/svgs/right_caret.svg"),
                info: "See all",
              ),
            ],
          )
        ],
      ),
    );
  }
}
