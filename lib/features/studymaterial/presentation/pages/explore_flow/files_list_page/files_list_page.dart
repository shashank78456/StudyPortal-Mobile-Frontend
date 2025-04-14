import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/download_file/download_file_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_files/fetch_files_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tabs/file_tabs.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';

class FilesListPage extends StatelessWidget {
  static MaterialPageRoute route(BuildContext context, String courseCode) {
    return MaterialPageRoute(
        builder: (context) => FilesListPage(courseCode: courseCode));
  }

  final String courseCode;

  const FilesListPage({super.key, required this.courseCode});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<FetchFilesCubit>().getFiles(courseCode);
    return BlocBuilder<FetchFilesCubit, FetchFilesState>(
      builder: (context, state) {
        if (state is FetchFilesInitial || state is FetchFilesLoading) {
          return const Loader();
        } else if (state is FetchFilesLoaded) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  courseCode,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
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
                    fileTiles: state.files
                        .where(
                          (file) => file.status == "approved",
                        )
                        .map((file) => FileTile(
                              file: file,
                            ))
                        .toList(),
                    screen: courseCode,
                  ),
                ],
              ),
            ),
          );
        } else if (state is FetchFilesFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text("unexpected error occurred"),
          );
        }
      },
    );
  }
}
