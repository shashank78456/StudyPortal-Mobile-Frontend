import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/profile_page/components/your_contributions.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/profile_page/components/action_buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Data that needs to be fecthed from data base
  // Name
  // Number of uploads
  // Number of requests
  // Department
  // Email

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Positioned.fill(
              top: 6,
              bottom: 6,
              child: SvgPicture.asset(
                "lib/core/svgs/profile_background.svg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 220,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 72,
                      width: 72,
                      child: Image.asset(
                        'lib/features/studymaterial/data/pre_integration/kambli.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Angad Kambli",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Department of Computer Science",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "a_kambli@cs.iitr.ac.in",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              YourContributions(size: size, uploads: 132, requests: 123),
              const SizedBox(
                height: 20,
              ),
              const ActionButtons(),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset("lib/core/svgs/sdslabs.svg"),
            ],
          ),
        ),
      ],
    ));
  }
}
