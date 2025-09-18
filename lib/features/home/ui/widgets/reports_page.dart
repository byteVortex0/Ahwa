import 'package:ahwa/features/home/logic/get_all_orders/get_all_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/get_top_selling_drinks/get_top_selling_drinks_cubit.dart';
import 'report_item.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Selling Drinks",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // List of drinks
          BlocBuilder<GetTopSellingDrinksCubit, GetTopSellingDrinksState>(
            builder: (context, state) {
              if (state is GetTopSellingDrinksLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetTopSellingDrinksError) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is GetTopSellingDrinksSuccess) {
                final topSellingDrinks = state.topSellingDrinks;
                if (topSellingDrinks.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No selling drinks yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    itemBuilder:
                        (BuildContext context, int index) => ReportItem(
                          title: topSellingDrinks[index].drinkType,
                          count: topSellingDrinks[index].count,
                        ),
                    separatorBuilder:
                        (BuildContext context, int index) =>
                            SizedBox(height: 10),
                    itemCount: topSellingDrinks.length,
                  ),
                );
              }
              return Container();
            },
          ),

          // Total Orders Served
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
                  builder: (context, state) {
                    if (state is GetAllOrdersLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }

                    if (state is GetAllOrdersError) {
                      return Center(child: Text(state.errorMessage));
                    }

                    if (state is GetAllOrdersSuccess) {
                      final allOrders = state.allOrders;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Orders Served",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${allOrders.length}",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.receipt_long,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
