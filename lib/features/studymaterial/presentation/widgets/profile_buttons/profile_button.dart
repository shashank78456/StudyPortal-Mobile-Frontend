import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.mainText,
      required this.subText,
      required this.iconPath,
      required this.onTap});

  final String mainText;
  final String subText;
  final String iconPath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(iconPath, width: 32, height: 32),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainText,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  subText,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF8E8E93)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
