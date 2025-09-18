import 'package:ahwa/features/home/data/models/order_model.dart';

abstract class OrdersRepo {
  Future<void> addOrder(OrderModel orderModel);

  Future<List<OrderModel>> getAllOrders();

  Future<void> markCompleted(int id);
}
