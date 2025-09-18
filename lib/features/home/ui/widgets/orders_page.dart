import 'package:flutter/material.dart';

import 'add_order_page.dart';
import 'orders_list_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(icon: Icon(Icons.add), text: "New Order"),
              Tab(icon: Icon(Icons.list), text: "All Orders"),
            ],
          ),

          Expanded(
            child: const TabBarView(
              children: [AddOrderPage(), OrdersListPage()],
            ),
          ),
        ],
      ),
    );
  }
}
