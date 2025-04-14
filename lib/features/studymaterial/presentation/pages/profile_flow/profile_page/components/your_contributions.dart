import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';

class YourContributions extends StatelessWidget {
  const YourContributions(
      {super.key,
      required this.size,
      required this.uploads,
      required this.requests});

  final Size size;
  final int uploads;
  final int requests;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: size.width,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 6, top: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: const Color(StudyPortalConstants.spStrokeGrey)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "lib/core/svgs/your_contribution.svg",
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Your contribution",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Stack(
            children: [
              Positioned.fill(
                top: 6,
                bottom: 6,
                child: SvgPicture.asset(
                  "lib/core/svgs/file_uploaded.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uploads.toString(),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Text(
                      "Files you uploaded",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Positioned.fill(
                top: 6,
                bottom: 6,
                child: SvgPicture.asset(
                  "lib/core/svgs/file_requested.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      requests.toString(),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Text(
                      "Files you requested",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
