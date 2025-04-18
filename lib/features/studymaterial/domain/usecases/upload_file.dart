import 'package:fpdart/fpdart.dart';
import 'package:studyportal/core/errors/failures.dart';
import 'package:studyportal/core/usecases/usecase.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/repository/repository.dart';

class UploadFile implements UseCase<File, File> {
  final Repository repository;
  const UploadFile(this.repository);

  @override
  Future<Either<Failure, File>> call(File file) async {
    if (file.path != null) {
      final response = await repository.uploadFile(file);
      return response.fold((failure) => Left(failure), (presignedUrl) async {
        file.s3Url = presignedUrl;
        final result = await repository.uploadFileToS3Bucket(file);
        return result.fold((failure) => Left(failure),
            (_) async => await repository.uploadFileComplete(file));
      });
    } else {
      return Left(Failure());
    }
  }
}
