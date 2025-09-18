import '../models/report_model.dart';
import 'orders_repo.dart';

class ReportRepo {
  final OrdersRepo repo;

  ReportRepo(this.repo);

  Future<List<ReportModel>> getTopSellingDrinks({bool topThree = false}) async {
    final orders = await repo.getAllOrders();

    final Map<String, int> drinkCounts = {};
    for (var order in orders) {
      drinkCounts[order.drinkType] = (drinkCounts[order.drinkType] ?? 0) + 1;
    }

    final sortedDrinks =
        drinkCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    final result =
        sortedDrinks
            .map((e) => ReportModel(drinkType: e.key, count: e.value))
            .toList();

    return topThree ? result.take(3).toList() : result;
  }
}
