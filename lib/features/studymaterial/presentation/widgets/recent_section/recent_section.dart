import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_recent_files/fetch_recent_files_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/more_info_button/more_info_button.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/home_flow/see_all_recent_page/see_all_recent_page.dart';

class RecentSection extends StatelessWidget {
  const RecentSection({
    super.key,
    required this.size,
    required this.state,
  });

  final Size size;
  final FetchRecentFilesState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 322.h,
      padding: const EdgeInsets.all(12).r,
      width: size.width.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: const Color(StudyPortalConstants.spStrokeGrey)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  right: 8,
                  top: 4,
                  bottom: 4,
                ).r,
                child: SvgPicture.asset(
                  "lib/core/svgs/hourglass.svg",
                  height: 16.h,
                  width: 16.w,
                ),
              ),
              Text(
                "Recent",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          SizedBox(
            height: 230.h,
            child: BlocBuilder<FetchRecentFilesCubit, FetchRecentFilesState>(
              builder: (context, state) {
                if (state is FetchRecentFilesLoading ||
                    state is FetchRecentFilesInitial) {
                  return const Loader();
                } else if (state is FetchRecentFilesFailure) {
                  return Text(state.message);
                } else if (state is FetchRecentFilesLoaded) {
                  final List<FileTile> recentTiles = state.recentFiles
                      .map((file) => FileTile(file: file))
                      .toList();
                  if (recentTiles.isEmpty) {
                    return const Center(
                      child: Text("No Recent Files"),
                    );
                  } else {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return recentTiles[index];
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 13.h,
                        );
                      },
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          SizedBox(
            height: 9.h,
          ),
          Row(
            children: [
              const Spacer(),
              MoreInfoButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SeeAllRecentPage()));
                  },
                  info: "See all",
                  icon: SvgPicture.asset(
                    "lib/core/svgs/right_caret.svg",
                    height: 16.h,
                    width: 16.w,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
