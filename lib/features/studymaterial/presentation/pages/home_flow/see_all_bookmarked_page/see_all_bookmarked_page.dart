import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_bookmarks/fetch_bookmarks_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tabs/file_tabs.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';

class SeeAllBookmarkedPage extends StatelessWidget {
  const SeeAllBookmarkedPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchBookmarksCubit>().getBookmarks();
    var size = MediaQuery.of(context).size;

    return BlocBuilder<FetchBookmarksCubit, FetchBookmarksState>(
      builder: (context, state) {
        if (state is FetchBookmarksLoading || state is FetchBookmarksInitial) {
          return const Loader();
        } else if (state is FetchBookmarksFailure) {
          return Text(state.message);
        } else if (state is FetchBookmarksLoaded) {
          final List<FileTile> fileTiles = state.bookmarks.map((file) {
            //Is there a need to handle invalid file type? Need to be discussed
            return FileTile(
              file: file,
            );
          }).toList();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bookmarked",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        FileTabs(
                          size: size,
                          fileTiles: fileTiles,
                          screen: "Bookmarked",
                        )
                      ])),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
