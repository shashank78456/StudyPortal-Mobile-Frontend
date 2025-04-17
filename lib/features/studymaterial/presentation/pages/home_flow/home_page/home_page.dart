import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/data/pre_integration/hardcoded_stuff.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_bookmarks/fetch_bookmarks_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_pins/fetch_pins_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_recent_files/fetch_recent_files_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/bookmarked_section/bookmarked_section.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/downloaded_section/downloaded_section.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/pinned_section/pinned_section.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/recent_section/recent_section.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/home_flow/see_all_pinned_page/see_all_pinned_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchPinsCubit>().getPins();
    context.read<FetchBookmarksCubit>().getBookmarks();
    context.read<FetchRecentFilesCubit>().getRecentFiles();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                width: size.width,
                height: 50.h,
                child: Row(
                  children: [
                    Text(
                      "Home",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.sp),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              BlocBuilder<FetchPinsCubit, FetchPinsState>(
                builder: (context, state) {
                  return PinnedSection(
                    state: state,
                    size: size,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SeeAllPinnedPage()));
                    },
                  );
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              BlocBuilder<FetchRecentFilesCubit, FetchRecentFilesState>(
                  builder: (context, state) {
                return RecentSection(size: size, state: state);
              }),
              SizedBox(
                height: 24.h,
              ),
              BlocBuilder<FetchBookmarksCubit, FetchBookmarksState>(
                builder: (context, state) {
                  return BookmarkedSection(state: state, size: size);
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              DownloadedSection(
                  size: size,
                  downloadedTiles: HardCodedConstants.downloadedTiles),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
