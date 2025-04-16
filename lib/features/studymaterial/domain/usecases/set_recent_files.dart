import 'package:fpdart/fpdart.dart';
import 'package:studyportal/core/errors/failures.dart';
import 'package:studyportal/core/usecases/usecase.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/repository/repository.dart';

class SetRecentFiles implements UseCase<File, File> {
  final Repository repository;
  const SetRecentFiles(this.repository);

  @override
  Future<Either<Failure, File>> call(File file) async {
    return await repository.setRecentFiles(file);
  }
}
