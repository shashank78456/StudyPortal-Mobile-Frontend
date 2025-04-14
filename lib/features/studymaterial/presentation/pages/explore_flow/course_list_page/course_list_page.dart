import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/domain/entities/branch.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_courses/fetch_courses_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/course_card/course_card.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/filters_page.dart/filters_page.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/loader/loader.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/scroll_section/scroll_section.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/pin_enum.dart';

class CourseListPage extends StatefulWidget {
  static MaterialPageRoute route(Branch branch) {
    return MaterialPageRoute(
      builder: (context) => CourseListPage(branch: branch),
    );
  }

  final Branch branch;
  const CourseListPage({super.key, required this.branch});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      useSafeArea: true,
      isScrollControlled: true,
      constraints: BoxConstraints(minHeight: double.infinity.h),
      context: context,
      builder: (context) {
        return const FiltersPage();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {
          _isFocused = _focusNode.hasFocus;
        }));
  }

  Map<int, List<CourseCard>> _groupCoursesBySemester(
      List<CourseCard> courseCards) {
    Map<int, List<CourseCard>> semesterCourses = {};

    for (var courseCard in courseCards) {
      semesterCourses
          .putIfAbsent(courseCard.course.semester, () => [])
          .add(courseCard);
    }

    return semesterCourses;
  }

  @override
  Widget build(BuildContext context) {
    context.read<FetchCoursesCubit>().getCourses(widget.branch.id);

    return BlocBuilder<FetchCoursesCubit, FetchCoursesState>(
      builder: (context, state) {
        if (state is FetchCoursesLoading || state is FetchCoursesInitial) {
          print(state);
          return const Loader();
        } else if (state is FetchCoursesLoaded) {
          final List<CourseCard> courseCards = state.courses.map((course) {
            return CourseCard(
              course: course,
              pin: Pin.none,
              // onTap: () => {},
            );
            //add onTap
          }).toList();
          final filteredCourseCards = courseCards
              .where((courseCard) =>
                  courseCard.course.branchId == widget.branch.id)
              .toList();
          print("widget branch id :${widget.branch.id}");

          final Map<int, List<CourseCard>> semesterWiseCourseCards =
              _groupCoursesBySemester(filteredCourseCards);

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
                      height: 50.h,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color:
                                  const Color(StudyPortalConstants.spRoyalBlue),
                              size: 24.r,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75.w,
                            child: Text(
                              widget.branch.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.sp),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: _showModalBottomSheet,
                            child: SvgPicture.asset("lib/core/svgs/filters.svg",
                                width: 24.w, height: 24.h),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search in ${widget.branch.name}",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: SvgPicture.asset(
                            "lib/core/svgs/search_icon.svg",
                            fit: BoxFit.scaleDown,
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 24.h);
                        },
                        itemCount: semesterWiseCourseCards.entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          final semester =
                              semesterWiseCourseCards.keys.elementAt(index);
                          final List<CourseCard> courses =
                              semesterWiseCourseCards[semester] ??
                                  <CourseCard>[];

                          int numberOfRows = (courses.length / 2).ceil();

                          return ScrollSection(
                            scrollSectionHeight: (160.h * numberOfRows +
                                12.h * (numberOfRows - 1)),
                            title: "Semester $semester",
                            rows: 3.5,
                            searchable: courses,
                            scroll: false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is FetchCoursesFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Text("unexpected error");
        }
      },
    );
  }
}
