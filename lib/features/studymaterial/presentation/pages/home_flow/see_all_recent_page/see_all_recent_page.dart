import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_recent_files/fetch_recent_files_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tabs/file_tabs.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';

class SeeAllRecentPage extends StatelessWidget {
  const SeeAllRecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchRecentFilesCubit>().getRecentFiles();
    var size = MediaQuery.of(context).size;

    return BlocBuilder<FetchRecentFilesCubit, FetchRecentFilesState>(
        builder: (context, state) {
      if (state is FetchRecentFilesLoading ||
          state is FetchRecentFilesInitial) {
        return const Loader();
      } else if (state is FetchRecentFilesFailure) {
        return Text(state.message);
      } else if (state is FetchRecentFilesLoaded) {
        final List<FileTile> recentTiles =
            state.recentFiles.map((file) => FileTile(file: file)).toList();
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  FileTabs(
                    size: size,
                    fileTiles: recentTiles,
                    screen: "Recent",
                  )
                ]),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
