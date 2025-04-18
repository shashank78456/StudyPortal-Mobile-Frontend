import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/file_type_enum.dart';

class FileIcons extends StatelessWidget {
  final FileType fileType;
  const FileIcons({super.key, required this.fileType});

  @override
  Widget build(BuildContext context) {
    switch (fileType) {
      case FileType.notes:
        return const FileIcon(
          color: Color(0xFF386ED3),
          title: "NOTES",
        );
      case FileType.book:
        return const FileIcon(
          color: Color(0xFFCF4141),
          title: "BOOK",
        );
      case FileType.link:
        return const FileIcon(
          color: Color(0xFF892DD1),
          title: "LINK",
        );
      case FileType.pyqs:
        return const FileIcon(
          color: Color(0xFF0F871D),
          title: "PYQS",
        );
      case FileType.tut:
        return const FileIcon(
          color: Color(0xFF946F11),
          title: "TUT",
        );

      default:
        return const Icon(Icons.not_accessible);
    }
  }
}

class FileIcon extends StatelessWidget {
  final Color color;
  final String title;
  const FileIcon({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5).r,
      alignment: Alignment.center,
      height: 50.r,
      width: 50.r,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 10.sp, color: Colors.white),
      ),
    );
  }
}
