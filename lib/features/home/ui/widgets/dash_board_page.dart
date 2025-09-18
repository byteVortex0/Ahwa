import 'package:ahwa/features/home/logic/get_all_orders/get_all_orders_cubit.dart';
import 'package:ahwa/features/home/logic/get_top_selling_drinks/get_top_selling_drinks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drink_bar.dart';
import 'summary_card.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
          builder: (context, state) {
            if (state is GetAllOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetAllOrdersError) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is GetAllOrdersSuccess) {
              final allOrders = state.allOrders;
              final pendingOrders = state.pendingOrders;
              final completedOrders = state.completedOrders;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Summary
                  Text(
                    "Today's Summary",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SummaryCard(
                    icon: Icons.receipt_long,
                    iconColor: Colors.orange,
                    title: "Total Orders",
                    value: "${allOrders.length}",
                  ),
                  SizedBox(height: 10),
                  const SizedBox(width: 12),
                  SummaryCard(
                    icon: Icons.task_alt,
                    iconColor: Colors.green,
                    title: "Completed",
                    value: "${completedOrders.length}",
                  ),
                  SizedBox(height: 10),
                  const SizedBox(width: 12),
                  SummaryCard(
                    icon: Icons.pending,
                    iconColor: Colors.amber,
                    title: "Pending",
                    value: "${pendingOrders.length}",
                  ),

                  SizedBox(height: 10),

                  // Popular Drinks
                  Text(
                    "Popular Drinks",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Drink Popularity",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              "Last 24 hours",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Bars
                        BlocBuilder<
                          GetTopSellingDrinksCubit,
                          GetTopSellingDrinksState
                        >(
                          builder: (context, state) {
                            if (state is GetTopSellingDrinksLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetTopSellingDrinksSuccess) {
                              final drinks = state.topSellingDrinks;

                              if (drinks.isEmpty) {
                                return const Text("No selling drinks yet.");
                              }

                              final maxCount = drinks
                                  .map((e) => e.count)
                                  .reduce((a, b) => a > b ? a : b);

                              return SizedBox(
                                height: 150,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:
                                      drinks.map((drink) {
                                        final heightFactor =
                                            drink.count / maxCount;
                                        final isTop = drink.count == maxCount;
                                        return DrinkBar(
                                          label: drink.drinkType,
                                          heightFactor: heightFactor,
                                          color: Colors.orange,
                                          highlight: isTop,
                                        );
                                      }).toList(),
                                ),
                              );
                            } else if (state is GetTopSellingDrinksError) {
                              return Center(child: Text(state.errorMessage));
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
