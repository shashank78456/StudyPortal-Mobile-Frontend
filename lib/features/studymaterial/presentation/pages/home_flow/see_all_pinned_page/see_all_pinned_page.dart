import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_pins/fetch_pins_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/branch_card/branch_card.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/scroll_section/scroll_section.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/pin_enum.dart';

class SeeAllPinnedPage extends StatelessWidget {
  const SeeAllPinnedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    context.read<FetchPinsCubit>().getPins();
    return BlocBuilder<FetchPinsCubit, FetchPinsState>(
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
          }).toList();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pinned",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
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
                    ScrollSection(
                        scrollSectionHeight: (160 * 4 - 18).h,
                        scroll: true,
                        rows: 4,
                        searchable: pinnedCards),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
