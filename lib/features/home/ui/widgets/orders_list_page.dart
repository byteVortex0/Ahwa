import 'package:ahwa/features/home/logic/get_all_orders/get_all_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/mark_completed/mark_completed_cubit.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
      builder: (context, state) {
        if (state is GetAllOrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetAllOrdersError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is GetAllOrdersSuccess) {
          final orders = state.allOrders;
          if (orders.isEmpty) {
            return Expanded(child: const Center(child: Text("No orders yet")));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(orders[index].customerName),
                  subtitle: Text(orders[index].drinkType),
                  trailing:
                      orders[index].isCompleted
                          ? const Icon(Icons.done, color: Colors.green)
                          : ElevatedButton(
                            onPressed: () {
                              context.read<MarkCompletedCubit>().markCompleted(
                                orders[index].id!,
                              );
                              context.read<GetAllOrdersCubit>().getAllOrders();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Mark Completed"),
                          ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
