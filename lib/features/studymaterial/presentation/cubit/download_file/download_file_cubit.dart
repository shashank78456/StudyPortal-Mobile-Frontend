import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/download_file.dart';

part 'download_file_state.dart';

class DownloadFileCubit extends Cubit<DownloadFileState> {
  final DownloadFile downloadfile;
  DownloadFileCubit({required this.downloadfile})
      : super(DownloadFileInitial());

  Future<void> downloadFile(File file) async {
    emit(DownloadFileLoading());
    final response = await downloadfile(file);
    response.fold((l) => emit(DownloadFileFailure(l.toString())),
        (r) => emit(DownloadFileSuccess(file: file)));
  }
}
