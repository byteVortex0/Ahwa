import 'package:ahwa/core/di/injection.dart';
import 'package:ahwa/core/utils/colors_manager.dart';
import 'package:ahwa/features/home/logic/add_orders/add_orders_cubit.dart';
import 'package:ahwa/features/home/logic/get_all_orders/get_all_orders_cubit.dart';
import 'package:ahwa/features/home/logic/get_top_selling_drinks/get_top_selling_drinks_cubit.dart';
import 'package:ahwa/features/home/ui/widgets/orders_page.dart';
import 'package:ahwa/features/home/ui/widgets/reports_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/mark_completed/mark_completed_cubit.dart';
import 'widgets/dash_board_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashBoardPage(),
    OrdersPage(),
    ReportsPage(),
  ];

  final List<String> _titles = const ["Dashboard", "Orders", "Reports"];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetAllOrdersCubit>()..getAllOrders(),
        ),
        BlocProvider(create: (context) => sl<AddOrdersCubit>()),
        BlocProvider(create: (context) => sl<MarkCompletedCubit>()),
        BlocProvider(
          create:
              (context) =>
                  sl<GetTopSellingDrinksCubit>()..getTopSellingDrinks(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            _titles[_currentIndex],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        body: _screens[_currentIndex],

        // Bottom Nav
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorsManager.primaryColor,
            unselectedItemColor: Colors.grey.shade500,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.coffee),
                label: "Reports",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
