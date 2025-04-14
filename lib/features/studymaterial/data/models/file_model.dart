import 'package:studyportal/features/studymaterial/domain/entities/file.dart';

class FileModel extends File {
  FileModel(
      {required super.id,
      required super.name,
      required super.courseCode,
      required super.s3Url,
      required super.status,
      required super.description,
      required super.type});

  factory FileModel.fromJson(Map<String, dynamic> map) {
    return FileModel(
        id: map["file_id"],
        name: map["file_name"],
        courseCode: map["course_code"],
        s3Url: map["file_s3_url"],
        status: map["file_status"] ??
            "approved", // can't find the file_status field in the json response from the get request, so hardcoded for right now
        description: map["file_description"],
        type: map["file_type"]);
  }
}
