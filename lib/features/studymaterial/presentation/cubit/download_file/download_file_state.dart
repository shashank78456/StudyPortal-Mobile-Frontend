part of 'download_file_cubit.dart';

sealed class DownloadFileState extends Equatable {
  const DownloadFileState();

  @override
  List<Object?> get props => [];
}

final class DownloadFileInitial extends DownloadFileState {}

final class DownloadFileLoading extends DownloadFileState {}

final class DownloadFileSuccess extends DownloadFileState {
  final File file;

  const DownloadFileSuccess({required this.file});

  @override
  List<Object?> get props => [file];
}

final class DownloadFileFailure extends DownloadFileState {
  final String message;

  const DownloadFileFailure(this.message);
  @override
  List<Object?> get props => [message];
}
