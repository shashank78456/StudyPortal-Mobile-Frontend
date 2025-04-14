import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_bookmarks/fetch_bookmarks_cubit.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/more_info_button/more_info_button.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/home_flow/see_all_bookmarked_page/see_all_bookmarked_page.dart';

class BookmarkedSection extends StatelessWidget {
  const BookmarkedSection({
    super.key,
    required this.size,
    required this.state,
  });

  final Size size;
  final FetchBookmarksState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 322.h,
      padding: const EdgeInsets.all(12),
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
                ),
                child: SvgPicture.asset(
                  "lib/core/svgs/bookmarked_icon.svg",
                  height: 16.h,
                  width: 16.w,
                ),
              ),
              Text(
                "Bookmarked",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          SizedBox(
            height: 230.h,
            child: BlocBuilder<FetchBookmarksCubit, FetchBookmarksState>(
              builder: (context, state) {
                if (state is FetchBookmarksLoading ||
                    state is FetchBookmarksInitial) {
                  return const Loader();
                } else if (state is FetchBookmarksFailure) {
                  return Text(state.message);
                } else if (state is FetchBookmarksLoaded) {
                  final List<FileTile> bookmarkedTiles =
                      state.bookmarks.map((file) {
                    //Is there a need to handle invalid file type? Need to be discussed
                    return FileTile(
                      file: file,
                    );
                    //add onTap
                  }).toList();
                  if (bookmarkedTiles.isEmpty) {
                    return const Center(
                      child: Text("No Bookmarks Added"),
                    );
                  } else {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return bookmarkedTiles[index];
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
                        builder: (context) => const SeeAllBookmarkedPage()));
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
