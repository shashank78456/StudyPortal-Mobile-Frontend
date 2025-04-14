import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_scroll_section/file_scroll_section.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/filter_tab/filter_tab.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/file_type_enum.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/search_bar/custom_search_bar.dart';

class FileTabs extends StatefulWidget {
  const FileTabs({
    super.key,
    required this.size,
    required this.fileTiles,
    required this.screen,
  });

  final Size size;
  final List<FileTile> fileTiles;
  final String screen;

  @override
  State<FileTabs> createState() => _FilterTabBarState();
}

class _FilterTabBarState extends State<FileTabs> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 6, vsync: this);
    _focusNode.addListener(() => setState(() {
          _isFocused = _focusNode.hasFocus;
        }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12).w,
          child: CustomSearchBar(
            searchableItems: widget.fileTiles,
            screen: widget.screen,
            isFocused: _isFocused,
            focusNode: _focusNode,
          ),
        ),
        if (!_isFocused)
          SizedBox(
              child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(),
                labelStyle: const TextStyle(color: Colors.white),
                labelPadding: const EdgeInsets.only(left: 8, right: 12).w,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  // _tabController.animateTo(index,
                  //     duration: const Duration(milliseconds: 500));
                },
                tabs: [
                  FilterTab(
                    constraintIndex: 0,
                    selectedIndex: _selectedIndex,
                    title: "All",
                  ),
                  FilterTab(
                    title: "Notes",
                    selectedIndex: _selectedIndex,
                    constraintIndex: 1,
                  ),
                  FilterTab(
                    title: "TUTs",
                    selectedIndex: _selectedIndex,
                    constraintIndex: 2,
                  ),
                  FilterTab(
                    title: "PYQs",
                    selectedIndex: _selectedIndex,
                    constraintIndex: 3,
                  ),
                  FilterTab(
                    title: "Books",
                    selectedIndex: _selectedIndex,
                    constraintIndex: 4,
                  ),
                  FilterTab(
                    title: "Links",
                    selectedIndex: _selectedIndex,
                    constraintIndex: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              IndexedStack(
                index: _selectedIndex,
                children: [
                  Visibility(
                    maintainState: true,
                    visible: _selectedIndex == 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12).w,
                      child: FileScrollSection(
                          size: widget.size, fileTiles: widget.fileTiles),
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: _selectedIndex == 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0).w,
                      child: FileScrollSection(
                          size: widget.size,
                          fileTiles: widget.fileTiles
                              .where((fileTile) =>
                                  fileTypeFromString(fileTile.file.type) ==
                                  FileType.notes)
                              .toList()),
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: _selectedIndex == 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0).w,
                      child: FileScrollSection(
                          size: widget.size,
                          fileTiles: widget.fileTiles
                              .where((fileTile) =>
                                  fileTypeFromString(fileTile.file.type) ==
                                  FileType.tut)
                              .toList()),
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: _selectedIndex == 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0).w,
                      child: FileScrollSection(
                          size: widget.size,
                          fileTiles: widget.fileTiles
                              .where((fileTile) =>
                                  fileTypeFromString(fileTile.file.type) ==
                                  FileType.pyqs)
                              .toList()),
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: _selectedIndex == 4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0).w,
                      child: FileScrollSection(
                          size: widget.size,
                          fileTiles: widget.fileTiles
                              .where((fileTile) =>
                                  fileTypeFromString(fileTile.file.type) ==
                                  FileType.book)
                              .toList()),
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: _selectedIndex == 5,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0).w,
                      child: FileScrollSection(
                          size: widget.size,
                          fileTiles: widget.fileTiles
                              .where((fileTile) =>
                                  fileTypeFromString(fileTile.file.type) ==
                                  FileType.link)
                              .toList()),
                    ),
                  ),
                ],
              )
            ],
          ))
      ],
    );
  }
}
