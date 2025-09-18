import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/orders_repo_impl.dart';

part 'mark_completed_state.dart';

class MarkCompletedCubit extends Cubit<MarkCompletedState> {
  MarkCompletedCubit(this.ordersRepo) : super(MarkCompletedInitial());

  final OrdersRepoImpl ordersRepo;

  Future<void> markCompleted(int id) async {
    emit(MarkCompletedLoading());
    try {
      await ordersRepo.markCompleted(id);
      emit(MarkCompletedSuccess());
    } catch (e) {
      emit(
        MarkCompletedError(errorMessage: 'Failed to mark order as completed'),
      );
    }
  }
}
