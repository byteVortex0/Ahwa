import 'package:ahwa/core/services/db_helper.dart';
import 'package:ahwa/features/home/data/models/order_model.dart';
import 'package:ahwa/features/home/data/repos/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DBHelper dbHelper;

  OrdersRepoImpl({required this.dbHelper});

  @override
  Future<void> addOrder(OrderModel orderModel) async {
    await dbHelper.insertOrder(orderModel: orderModel);
  }

  @override
  Future<List<OrderModel>> getAllOrders({
    bool pending = false,
    bool completed = false,
  }) async {
    return await dbHelper
        .getOrders(onlyPending: pending, onlyCompleted: completed)
        .then((value) => value.map((e) => OrderModel.fromMap(e)).toList());
  }

  @override
  Future<void> markCompleted(int id) async {
    await dbHelper.markCompleted(id);
  }
}
