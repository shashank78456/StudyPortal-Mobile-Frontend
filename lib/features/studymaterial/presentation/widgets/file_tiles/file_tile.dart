import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/download_file/download_file_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/set_recent_files/set_recent_files_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/utils/searchable.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_icons/file_icons.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/file_type_enum.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/vertical_dots/more_vertical_dots.dart';

class FileTile extends StatelessWidget implements Searchable {
  final File file;
  const FileTile({
    required this.file,
    super.key,
  });
  @override
  String get title => file.name;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DownloadFileCubit, DownloadFileState>(
            listener: (context, state) {
          if (state is DownloadFileFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            print("Failure response : ${state.message}");
          } else if (state is DownloadFileSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.file.name)));
          }
        })
      ],
      child: BlocBuilder<SetRecentFilesCubit, SetRecentFilesState>(
          builder: (context, state) {
        final setRecentFilesCubit = context.read<SetRecentFilesCubit>();
        return InkWell(
          onTap: () async {
            await checkAndOpenPdf(file, context.read<DownloadFileCubit>());
            setRecentFilesCubit.setrecentfiles(file);
          },
          child: SizedBox(
            height: 48.h,
            child: Row(
              children: [
                FileIcons(fileType: fileTypeFromString(file.type)),
                SizedBox(width: 16.w),
                Container(
                  constraints: BoxConstraints(maxWidth: 252.w),
                  child: Text(
                    title,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                ),
                const Spacer(),
                SizedBox(width: 8.w),
                MoreVerticalDots(
                  file: file,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> checkAndOpenPdf(
      File file, DownloadFileCubit downloadFileCubit) async {
    final String fileName = file.name;

    try {
      String filePath = "";

      if (io.Platform.isAndroid) {
        io.Directory? baseDir = await getExternalStorageDirectory();
        final downloadsDir =
            io.Directory("${baseDir!.path}/StudyPortal/Downloads");

        filePath = "${downloadsDir.path}/$fileName";
      } else {
        final dir = await getApplicationSupportDirectory();
        filePath = "${dir.path}/StudyPortal/Downloads/$fileName";
      }

      final pdfFile = io.File(filePath);

      if (await pdfFile.exists()) {
        print("File already exists, opening...");
      } else {
        print("File not found, downloading...");
        
        downloadFileCubit.downloadfile(file);
      }

      final result = await OpenFile.open(filePath);
      print("Open result: ${result.message}");
    } catch (e) {
      print("Error opening PDF: $e");
    }
  }
}
