import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/set_recent_files.dart';

part 'set_recent_files_state.dart';

class SetRecentFilesCubit extends Cubit<SetRecentFilesState> {
  final SetRecentFiles setrecentfiles;
  SetRecentFilesCubit({required this.setrecentfiles})
      : super(SetRecentFilesInitial());

  Future<void> setRecentFiles(File file) async {
    emit(SetRecentFilesLoading());
    final response = await setrecentfiles(file);
    response.fold((failure) => emit(SetRecentFilesFailure(failure.message)),
        (file) => emit(SetRecentFilesLoaded(file)));
  }
}
