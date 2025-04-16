part of 'set_recent_files_cubit.dart';

sealed class SetRecentFilesState extends Equatable {
  const SetRecentFilesState();

  @override
  List<Object?> get props => [];
}

final class SetRecentFilesInitial extends SetRecentFilesState {}

final class SetRecentFilesLoading extends SetRecentFilesState {}

final class SetRecentFilesLoaded extends SetRecentFilesState {
  final File file;
  const SetRecentFilesLoaded(this.file);

  @override
  List<Object?> get props => [file];
}

final class SetRecentFilesFailure extends SetRecentFilesState {
  final String message;
  const SetRecentFilesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
