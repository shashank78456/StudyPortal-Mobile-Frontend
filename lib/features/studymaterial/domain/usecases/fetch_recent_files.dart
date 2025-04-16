import 'package:fpdart/fpdart.dart';
import 'package:studyportal/core/errors/failures.dart';
import 'package:studyportal/core/usecases/usecase.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/repository/repository.dart';

class FetchRecentFiles implements UseCase<List<File>, NoParams> {
  final Repository repository;
  const FetchRecentFiles(this.repository);

  @override
  Future<Either<Failure, List<File>>> call(NoParams params) async {
    return await repository.fetchRecentFiles();
  }
}
