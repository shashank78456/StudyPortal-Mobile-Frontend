import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/filter_tab/filter_tab.dart';

class RequestedFileTabs extends StatefulWidget {
  const RequestedFileTabs({super.key});

  @override
  _FileTypeSelectionState createState() => _FileTypeSelectionState();
}

class _FileTypeSelectionState extends State<RequestedFileTabs> {
  int _selectedIndex = 0;

  final List<String> fileTypes = [
    'Notes',
    'TUTs',
    'PYQs',
    'Books',
    'Links',
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getSelectedFileType() {
    return fileTypes[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0.w, // Space between items
        runSpacing: 8.0.h, // Space between rows
        children: List.generate(fileTypes.length, (index) {
          return GestureDetector(
            onTap: () => _onTabSelected(index),
            child: FilterTab(
              title: fileTypes[index],
              selectedIndex: _selectedIndex,
              constraintIndex: index,
              tabBar: false,
            ),
          );
        }),
      ),
    );
  }
}
