import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/utils/searchable.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/not_found_box/not_found_box.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar(
      {super.key,
      required this.searchableItems,
      required this.screen,
      required this.isFocused,
      required this.focusNode});

  final List<Searchable> searchableItems;
  final String screen;
  final bool isFocused;
  final FocusNode focusNode;

  @override
  State<StatefulWidget> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController searchController = TextEditingController();

  List filteredList = [];
  @override
  void initState() {
    super.initState();
    filteredList = widget.searchableItems;
  }

  void _filterList(String query) {
    setState(() {
      filteredList = widget.searchableItems
          .where(
              (file) => file.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: "Search files in ${widget.screen}",
            prefixIcon: SvgPicture.asset(
              "lib/core/svgs/search_icon.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
          onChanged: _filterList,
        ),
        SizedBox(height: 10.h),
        if (widget.isFocused && filteredList.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 5).w,
            alignment: Alignment.centerLeft,
            child: Text(
              "Matching files in ${widget.screen}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        SizedBox(
          height: 10.h,
        ),
        if (widget.isFocused && filteredList.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12).r,
            margin: const EdgeInsets.only(bottom: 20).h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color(StudyPortalConstants.spStrokeGrey)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              children: [
                for (int index = 0; index < filteredList.length; index++)
                  Column(
                    children: [
                      filteredList[index],
                      SizedBox(
                        height: 13.h,
                      ),
                    ],
                  )
              ],
            ),
          ),
        if (widget.isFocused) const NotFoundBox(),
        if (widget.isFocused) SizedBox(height: 20.h),
      ],
    );
  }
}
