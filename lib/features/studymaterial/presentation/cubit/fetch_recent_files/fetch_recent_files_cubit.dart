import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studyportal/core/usecases/usecase.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_recent_files.dart';

part 'fetch_recent_files_state.dart';

class FetchRecentFilesCubit extends Cubit<FetchRecentFilesState> {
  final FetchRecentFiles fetchrecentfiles;
  FetchRecentFilesCubit({required this.fetchrecentfiles})
      : super(FetchRecentFilesInitial());

  Future<void> getRecentFiles() async {
    emit(FetchRecentFilesLoading());
    final response = await fetchrecentfiles(NoParams());
    response.fold((failure) => emit(FetchRecentFilesFailure(failure.message)),
        (recentFiles) => emit(FetchRecentFilesLoaded(recentFiles)));
  }
}
