import 'package:ahwa/features/home/data/repos/orders_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';

part 'get_all_orders_state.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  GetAllOrdersCubit(this.ordersRepo) : super(GetAllOrdersInitial());

  final OrdersRepoImpl ordersRepo;

  Future<void> getAllOrders() async {
    emit(GetAllOrdersLoading());
    try {
      final allOrders = await ordersRepo.getAllOrders();
      final pendingOrders = await ordersRepo.getAllOrders(pending: true);
      final completedOrders = await ordersRepo.getAllOrders(completed: true);

      emit(
        GetAllOrdersSuccess(
          allOrders: allOrders,
          pendingOrders: pendingOrders,
          completedOrders: completedOrders,
        ),
      );
    } catch (e) {
      emit(GetAllOrdersError(errorMessage: 'Failed to get orders'));
    }
  }
}
