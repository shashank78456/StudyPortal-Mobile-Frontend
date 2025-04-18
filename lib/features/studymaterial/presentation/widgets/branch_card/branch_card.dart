import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/domain/entities/branch.dart';
import 'package:studyportal/features/studymaterial/domain/entities/pin.dart'
    as pin_model;
import 'package:studyportal/features/studymaterial/presentation/cubit/add_pin/add_pin_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/remove_pin/remove_pin_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/explore_flow/course_list_page/course_list_page.dart';
import 'package:studyportal/features/studymaterial/presentation/utils/searchable.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/bookmarked_pin/pin_active.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/bookmarked_pin/pin_inactive.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/pin_enum.dart';

class BranchCard extends StatefulWidget implements Searchable {
  final Pin pin;
  final VoidCallback? onTap;
  final Branch branch;

  const BranchCard(
      {super.key, required this.branch, required this.pin, this.onTap});

  @override
  String get title => branch.name;

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  late Pin _pin;

  @override
  void initState() {
    super.initState();
    _pin = widget.pin;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<RemovePinCubit, RemovePinState>(
              listener: (context, state) {
            if (state is RemovePinFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is RemovePinSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pin removed successfully")));
              setState(() {
                _pin = Pin.inactive;
              });
            }
          }),
          BlocListener<AddPinCubit, AddPinState>(listener: (context, state) {
            if (state is AddPinFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is AddPinSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pin added successfully")));
              setState(() {
                _pin = Pin.active;
              });
            }
          }),
        ],
        child: GestureDetector(
          // onTap: onTap ??
          onTap: widget.onTap ??
              () {
                Navigator.of(context).push(
                  CourseListPage.route(widget.branch),
                );
              },
          child: Container(
            width: 160.w,
            height: 160.h,
            padding: const EdgeInsets.only(bottom: 12).w,
            decoration: BoxDecoration(
              color:
                  Color(StudyPortalConstants.spColorList[widget.branch.id % 4]),
              borderRadius: BorderRadius.circular(12).w,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12).w,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Opacity(
                        opacity: 1,
                        child: SvgPicture.asset(
                          "lib/core/svgs/card_design.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.white38, BlendMode.srcIn),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: InkWell(
                          onTap: () {
                            if (_pin == Pin.active) {
                              context.read<RemovePinCubit>().removepin(
                                  pin_model.Pin(branchId: widget.branch.id));
                            } else if (_pin == Pin.inactive) {
                              context.read<AddPinCubit>().addPin(
                                  pin_model.Pin(branchId: widget.branch.id));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10).w,
                            child: (_pin == Pin.inactive)
                                ? const PinInactive()
                                : (_pin == Pin.active)
                                    ? const SizedBox(child: PinActive())
                                    : const Opacity(opacity: 0),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16).w,
                    width: double.infinity.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.branch.name,
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          widget.branch.department,
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
