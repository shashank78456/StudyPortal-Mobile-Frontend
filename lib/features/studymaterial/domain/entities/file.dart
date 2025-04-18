class File {
  final int id;
  final String name;
  final String courseCode;
  String s3Url;
  final String status;
  final String description;
  final String type;
  String? path;

  File(
      {required this.id,
      required this.name,
      required this.courseCode,
      required this.s3Url,
      required this.status,
      required this.description,
      required this.type,
      this.path});

  factory File.fromJson(Map<String, dynamic> map) {
    return File(
        id: map["id"],
        name: map["name"],
        courseCode: map["courseCode"],
        s3Url: map["s3_url"],
        status: map["status"],
        description: map["description"],
        type: map["type"],
        path: map["path"] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "courseCode": courseCode,
      "s3_url": s3Url,
      "status": status,
      "description": description,
      "type": type,
      "path": path,
    };
  }
}
