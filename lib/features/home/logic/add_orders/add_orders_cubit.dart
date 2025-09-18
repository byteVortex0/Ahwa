import 'package:ahwa/features/home/data/repos/orders_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';

part 'add_orders_state.dart';

class AddOrdersCubit extends Cubit<AddOrdersState> {
  AddOrdersCubit(this.ordersRepo) : super(AddOrdersInitial());

  final OrdersRepoImpl ordersRepo;

  Future<void> addOrder(OrderModel orderModel) async {
    emit(AddOrdersLoading());
    try {
      await ordersRepo.addOrder(orderModel);
      emit(AddOrdersSuccess());
    } catch (e) {
      emit(AddOrdersError('Failed to add order'));
    }
  }
}
