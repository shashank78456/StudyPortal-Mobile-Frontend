part of 'fetch_recent_files_cubit.dart';

sealed class FetchRecentFilesState extends Equatable {
  const FetchRecentFilesState();

  @override
  List<Object?> get props => [];
}

final class FetchRecentFilesInitial extends FetchRecentFilesState {}

final class FetchRecentFilesLoading extends FetchRecentFilesState {}

final class FetchRecentFilesLoaded extends FetchRecentFilesState {
  final List<File> recentFiles;
  const FetchRecentFilesLoaded(this.recentFiles);

  @override
  List<Object?> get props => [recentFiles];
}

final class FetchRecentFilesFailure extends FetchRecentFilesState {
  final String message;
  const FetchRecentFilesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
