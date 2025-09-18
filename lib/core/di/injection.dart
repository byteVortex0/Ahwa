import 'package:ahwa/core/services/db_helper.dart';
import 'package:ahwa/features/home/data/repos/report_repo.dart';
import 'package:ahwa/features/home/logic/add_orders/add_orders_cubit.dart';
import 'package:ahwa/features/home/logic/get_all_orders/get_all_orders_cubit.dart';
import 'package:ahwa/features/home/logic/mark_completed/mark_completed_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repos/orders_repo.dart';
import '../../features/home/data/repos/orders_repo_impl.dart';
import '../../features/home/logic/get_top_selling_drinks/get_top_selling_drinks_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> setupInjection() async {
  sl.registerSingleton<DBHelper>(DBHelper());

  sl.registerSingleton<OrdersRepo>(OrdersRepoImpl(dbHelper: sl()));

  sl.registerSingleton<ReportRepo>(ReportRepo(sl()));

  sl.registerSingleton<OrdersRepoImpl>(OrdersRepoImpl(dbHelper: sl()));

  sl.registerFactory(() => GetAllOrdersCubit(sl()));
  sl.registerFactory(() => AddOrdersCubit(sl()));
  sl.registerFactory(() => GetTopSellingDrinksCubit(sl()));
  sl.registerFactory(() => MarkCompletedCubit(sl()));
}
