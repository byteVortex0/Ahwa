part of 'mark_completed_cubit.dart';

@immutable
sealed class MarkCompletedState {}

final class MarkCompletedInitial extends MarkCompletedState {}

final class MarkCompletedLoading extends MarkCompletedState {}

final class MarkCompletedSuccess extends MarkCompletedState {}

final class MarkCompletedError extends MarkCompletedState {
  final String errorMessage;
  MarkCompletedError({required this.errorMessage});
}
