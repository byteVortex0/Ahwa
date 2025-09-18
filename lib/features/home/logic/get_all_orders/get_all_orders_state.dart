part of 'get_all_orders_cubit.dart';

@immutable
sealed class GetAllOrdersState {}

final class GetAllOrdersInitial extends GetAllOrdersState {}

final class GetAllOrdersLoading extends GetAllOrdersState {}

final class GetAllOrdersSuccess extends GetAllOrdersState {
  final List<OrderModel> allOrders;
  final List<OrderModel> pendingOrders;
  final List<OrderModel> completedOrders;
  GetAllOrdersSuccess({
    required this.allOrders,
    required this.pendingOrders,
    required this.completedOrders,
  });
}

final class GetAllOrdersError extends GetAllOrdersState {
  final String errorMessage;
  GetAllOrdersError({required this.errorMessage});
}
