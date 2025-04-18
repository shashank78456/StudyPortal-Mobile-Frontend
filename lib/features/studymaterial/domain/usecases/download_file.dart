import 'package:fpdart/fpdart.dart';
import 'package:studyportal/core/errors/failures.dart';
import 'package:studyportal/core/usecases/usecase.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/repository/repository.dart';

class DownloadFile implements UseCase<File, File> {
  final Repository repository;

  DownloadFile(this.repository);
  @override
  Future<Either<Failure, File>> call(File file) async {
    final response = await repository.fetchFile(file.id);
    return response.fold((failue) => Left(failue), (downloadUrl) async {
      file.s3Url = downloadUrl;
      return await repository.downloadFile(file);
    });
  }
}
