import 'package:fpdart/fpdart.dart';
import 'package:studyportal/core/errors/exceptions.dart';
import 'package:studyportal/core/errors/failures.dart';
import 'package:studyportal/features/studymaterial/data/datasources/remote_data_source.dart';
import 'package:studyportal/features/studymaterial/domain/entities/bookmark.dart';
import 'package:studyportal/features/studymaterial/domain/entities/branch.dart';
import 'package:studyportal/features/studymaterial/domain/entities/course.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/entities/pin.dart';
import 'package:studyportal/features/studymaterial/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  const RepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Branch>>> fetchBranches() async {
    try {
      final branches = await remoteDataSource.fetchBranches();
      return right(branches);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Branch>>> fetchPins() async {
    try {
      final pins = await remoteDataSource.fetchPins();
      return right(pins);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<File>>> fetchBookmarks() async {
    try {
      final bookmarks = await remoteDataSource.fetchBookmarks();
      return right(bookmarks);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> fetchCourses(int branchId) async {
    try {
      final courses = await remoteDataSource.fetchCourses(branchId);
      return right(courses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<File>>> fetchFiles(String courseCode) async {
    try {
      final files = await remoteDataSource.fetchFiles(courseCode);
      return right(files);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> fetchFile(int fileId) async {
    try {
      final url = await remoteDataSource.fetchFile(fileId);
      return right(url);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Bookmark>> addBookmark(Bookmark bookmark) async {
    try {
      await remoteDataSource.addBookmark(bookmark);
      return right(bookmark);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Pin>> addPin(Pin pin) async {
    try {
      await remoteDataSource.addPin(pin);
      return right(pin);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Bookmark>> removeBookmark(Bookmark bookmark) async {
    try {
      await remoteDataSource.removeBookmark(bookmark);
      return right(bookmark);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Pin>> removePin(Pin pin) async {
    try {
      await remoteDataSource.removePin(pin);
      return right(pin);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, File>> downloadFile(File file) async {
    try {
      await remoteDataSource.downloadFile(file);
      return right(file);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, String>> uploadFile(File file) async {
    try {
      final String url = await remoteDataSource.uploadFile(file);
      return right(url);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, File>> uploadFileComplete(File file) async {
    try {
      await remoteDataSource.uploadFileComplete(file);
      return right(file);
    } on ServerException catch (e) {
      return left(Failure((e.message)));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFileToS3Bucket(
      String filePath, String fileUrl) async {
    try {
      await remoteDataSource.uploadFileToS3Bucket(filePath, fileUrl);
      return right(fileUrl);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
