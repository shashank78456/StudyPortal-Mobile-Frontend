import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/more_info_button/more_info_button.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/home_flow/see_all_downloaded_page/see_all_downloaded_page.dart';

class DownloadedSection extends StatelessWidget {
  const DownloadedSection({
    super.key,
    required this.size,
    required this.downloadedTiles,
  });

  final Size size;
  final List<FileTile> downloadedTiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 322.h,
      padding: const EdgeInsets.all(12).w,
      // width: size.width.w,
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
                ).r,
                child: SvgPicture.asset(
                  "lib/core/svgs/downloaded_icon.svg",
                  height: 16.h,
                  width: 16.w,
                ),
              ),
              Text(
                "Downloaded",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          SizedBox(
            height: 230.h,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return downloadedTiles[index];
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 13.h,
                );
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
                        builder: (context) => const SeeAllDownloadedPage()));
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
