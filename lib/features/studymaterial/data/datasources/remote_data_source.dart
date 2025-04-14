import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'dart:io' as file_handler;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studyportal/core/errors/exceptions.dart';
import 'package:studyportal/features/studymaterial/data/models/branch_model.dart';
import 'package:studyportal/features/studymaterial/data/models/course_model.dart';
import 'package:studyportal/features/studymaterial/data/models/file_model.dart';
import 'package:studyportal/features/studymaterial/domain/entities/bookmark.dart';
import 'package:studyportal/features/studymaterial/domain/entities/branch.dart';
import 'package:studyportal/features/studymaterial/domain/entities/course.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/entities/pin.dart';

abstract interface class RemoteDataSource {
  Future<List<Branch>> fetchBranches();
  Future<List<Branch>> fetchPins();
  Future<List<File>> fetchBookmarks();
  Future<List<Course>> fetchCourses(int branchId);
  Future<List<File>> fetchFiles(String courseCode);
  Future<String> fetchFile(int fileId);
  Future<void> addPin(Pin pin);
  Future<void> addBookmark(Bookmark bookmark);
  Future<void> removePin(Pin pin);
  Future<void> removeBookmark(Bookmark bookmark);
  Future<void> downloadFile(File file);
  Future<String> uploadFile(File file);
  Future<void> uploadFileComplete(File file);
  Future<void> uploadFileToS3Bucket(String fileName, String fileUrl);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final String apiEndpoint = 'http://127.0.0.1:4000';

  @override
  Future<List<Branch>> fetchBranches() async {
    try {
      final response = await http.get(Uri.parse("$apiEndpoint/api/branches"));

      if (response.statusCode != 200) {
        throw ServerException(
            "Failed to load branches: ${response.statusCode}");
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData["data"] == null) {
        throw const ServerException("Empty Branch List");
      }

      return (responseData["data"] as List<dynamic>)
          .map((branch) => BranchModel.fromJson(branch))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Branch>> fetchPins() async {
    try {
      final response = await http.get(Uri.parse("$apiEndpoint/api/pins"));

      if (response.statusCode != 200) {
        throw ServerException("Failed to load pins: ${response.statusCode}");
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData["data"] == null) {
        throw const ServerException("No Pins");
      }

      return (responseData["data"] as List<dynamic>)
          .map((pin) => BranchModel.fromJson(pin))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<File>> fetchBookmarks() async {
    try {
      final response = await http.get(Uri.parse("$apiEndpoint/api/bookmarks"));

      if (response.statusCode != 200) {
        throw ServerException(
            "Failed to load bookmarks: ${response.statusCode}");
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData["data"] == null) {
        throw const ServerException("No Bookmarks");
      }

      return (responseData["data"] as List<dynamic>)
          .map((bookmark) => FileModel.fromJson(bookmark))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Course>> fetchCourses(int branchId) async {
    try {
      final response = await http
          .get(Uri.parse("$apiEndpoint/api/courses/?branch_id=$branchId"));

      if (response.statusCode != 200) {
        throw ServerException("Failed to load courses: ${response.statusCode}");
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData["data"] == null) {
        throw const ServerException("No Courses");
      }
      return (responseData["data"] as List<dynamic>).map((course) {
        final fileIds =
            (course["files"] as List<dynamic>).map((e) => e as int).toList();
        course["files"] =
            fileIds; // Optional, in case fromJson expects List<int>
        return CourseModel.fromJson(course);
      }).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<File>> fetchFiles(String courseCode) async {
    try {
      final response =
          await http.get(Uri.parse("$apiEndpoint/api/course-mat/$courseCode"));

      if (response.statusCode != 200) {
        throw ServerException("Failed to load files: ${response.statusCode}");
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData["data"] == null) {
        throw const ServerException("No Files");
      }
      print(responseData["data"][0]);
      final res = (responseData["data"] as List<dynamic>)
          .map((file) => FileModel.fromJson(file))
          .toList();

      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> fetchFile(int fileId) async {
    try {
      final response =
          await http.get(Uri.parse("$apiEndpoint/api/get-file/$fileId"));

      if (response.statusCode != 200) {
        throw ServerException("Failed to get file: ${response.statusCode}");
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData["url"] == null) {
        throw const ServerException("No Such File");
      }

      return responseData["url"];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addBookmark(Bookmark bookmark) async {
    try {
      final response = await http.post(
        Uri.parse("$apiEndpoint/api/add-bookmark/?file_id=${bookmark.fileId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 201) {
        throw ServerException("Failed to add bookmark: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addPin(Pin pin) async {
    try {
      final response = await http.post(
        Uri.parse("$apiEndpoint/api/add-pin/?branch_id=${pin.branchId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 201) {
        throw ServerException("Failed to add pin: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeBookmark(Bookmark bookmark) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "$apiEndpoint/api/remove-bookmark/?file_id=${bookmark.fileId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 201) {
        throw ServerException(
            "Failed to remove bookmark: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removePin(Pin pin) async {
    try {
      final response = await http.delete(
        Uri.parse("$apiEndpoint/api/remove-pin/?branch_id=${pin.branchId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 201) {
        throw ServerException("Failed to remove pin: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> downloadFile(File file) async {
    final String url = file.s3Url;
    final String fileName = file.name;

    try {
      if (file_handler.Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        bool hasPermission = false;

        if (sdkInt >= 30) {
          var status = await Permission.manageExternalStorage.status;
          if (!status.isGranted) {
            status = await Permission.manageExternalStorage.request();
          }
          hasPermission = status.isGranted;
        } else {
          var status = await Permission.storage.status;
          if (!status.isGranted) {
            status = await Permission.storage.request();
          }
          hasPermission = status.isGranted;
        }

        if (!hasPermission) {
          await openAppSettings();
          throw Exception("Storage permission not granted");
        }

        // Use a safe path
        file_handler.Directory? baseDir = await getExternalStorageDirectory();

        // Create custom subfolder
        final downloadsDir =
            file_handler.Directory("${baseDir!.path}/StudyPortal/Downloads");
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }

        final filePath = "${downloadsDir.path}/$fileName";

        Dio dio = Dio();
        await dio.download(
          url,
          filePath,
          options: Options(
            headers: {
              'User-Agent': 'Mozilla/5.0',
              'Accept': 'application/pdf',
            },
          ),
          onReceiveProgress: (received, total) {
            if (total != -1) {
              print(
                  "Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
            }
          },
        );

        print("PDF saved at: $filePath");
      } else {
        // iOS or other platforms
        final dir = await getApplicationSupportDirectory();
        final filePath = "${dir.path}/StudyPortal/Downloads/$fileName";
        final downloadsDir =
            file_handler.Directory("${dir.path}/StudyPortal/Downloads");
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }

        Dio dio = Dio();
        await dio.download(url, filePath);
        print("PDF saved at: $filePath");
      }
    } catch (e) {
      print("Download error: $e");
      throw Exception("Failed to download file: $e");
    }
  }

  @override
  Future<String> uploadFile(File file) async {
    try {
      final response =
          await http.post(Uri.parse("$apiEndpoint/api/upload-file"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "course_code": file.courseCode,
                "filename": file.name,
                "description": file.description,
                "type": file.type,
              }));

      final Map<String, dynamic> responseData = json.decode(response.body);

      try {
        if (responseData["url"] == null) {
          throw const ServerException("Failed to upload file");
        } else {
          return responseData["url"];
        }
      } catch (e) {
        throw const ServerException("Failed to upload file");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> uploadFileComplete(File file) async {
    try {
      final response =
          await http.patch(Uri.parse("$apiEndpoint/api/upload-file-complete"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({"id": file.id}));

      if (response.statusCode != 200) {
        //need to confirm statuscode
        throw ServerException("Failed to upload file: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> uploadFileToS3Bucket(String filePath, String fileUrl) async {
    try {
      final file_handler.File file = file_handler.File(filePath);

      if (!await file.exists()) {
        throw ServerException("File does not exist at $filePath");
      }

      final bytes = await file.readAsBytes();

      final response = await http.put(
        Uri.parse(fileUrl),
        headers: {
          "Content-Type": "application/octet-stream",
        },
        body: bytes,
      );

      if (response.statusCode != 200) {
        throw const ServerException(
          'Failed to upload file',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
