import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_files.dart';

part 'fetch_files_state.dart';

class FetchFilesCubit extends Cubit<FetchFilesState> {
  final FetchFiles fetchFiles;

  FetchFilesCubit({required this.fetchFiles}) : super(FetchFilesInitial());

  Future<void> getFiles(String courseCode) async {
    emit(FetchFilesLoading());
    final response = await fetchFiles(courseCode);
    print(response);
    response.fold((failure) => emit(FetchFilesFailure(failure.message)),
        (files) => emit(FetchFilesLoaded(files)));
  }
}
