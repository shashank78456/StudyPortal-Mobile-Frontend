import 'package:fpdart/fpdart.dart';
import 'package:studyportal/core/errors/failures.dart';
import 'package:studyportal/features/studymaterial/domain/entities/bookmark.dart';
import 'package:studyportal/features/studymaterial/domain/entities/branch.dart';
import 'package:studyportal/features/studymaterial/domain/entities/course.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/entities/pin.dart';

abstract interface class Repository {
  Future<Either<Failure, List<Branch>>> fetchBranches();
  Future<Either<Failure, List<Branch>>> fetchPins();
  Future<Either<Failure, List<File>>> fetchBookmarks();
  Future<Either<Failure, List<Course>>> fetchCourses(int branchId);
  Future<Either<Failure, List<File>>> fetchFiles(String courseCode);
  Future<Either<Failure, String>> fetchFile(int fileId);
  Future<Either<Failure, Pin>> addPin(Pin pin);
  Future<Either<Failure, Bookmark>> addBookmark(Bookmark bookmark);
  Future<Either<Failure, Pin>> removePin(Pin pin);
  Future<Either<Failure, Bookmark>> removeBookmark(Bookmark bookmark);
  Future<Either<Failure, File>> downloadFile(File file);
  Future<Either<Failure, String>> uploadFile(File file);
  Future<Either<Failure, File>> uploadFileComplete(File file);
  Future<Either<Failure, File>> uploadFileToS3Bucket(File file);
  Future<Either<Failure, List<File>>> fetchRecentFiles();
  Future<Either<Failure, File>> setRecentFiles(File file);
}
