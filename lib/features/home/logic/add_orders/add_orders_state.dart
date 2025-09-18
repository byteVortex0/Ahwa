part of 'add_orders_cubit.dart';

@immutable
sealed class AddOrdersState {}

final class AddOrdersInitial extends AddOrdersState {}

final class AddOrdersLoading extends AddOrdersState {}

final class AddOrdersSuccess extends AddOrdersState {
  AddOrdersSuccess();
}

final class AddOrdersError extends AddOrdersState {
  final String errorMessage;
  AddOrdersError(this.errorMessage);
}
