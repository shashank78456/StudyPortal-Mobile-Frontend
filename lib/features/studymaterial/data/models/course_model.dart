import 'package:studyportal/features/studymaterial/domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel(
      {required super.courseCode,
      required super.courseName,
      required super.semester,
      required super.branchId,
      required super.id,
      required super.files});

  factory CourseModel.fromJson(Map<String, dynamic> map) {
    return CourseModel(
      id: map["id"],
      courseCode: map["course_code"],
      courseName: map["course_name"],
      semester: map["semester"],
      branchId: map["branch"],
      files: map["files"],
    );
  }
}
