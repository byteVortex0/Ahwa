import 'package:ahwa/features/home/data/repos/report_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/report_model.dart';

part 'get_top_selling_drinks_state.dart';

class GetTopSellingDrinksCubit extends Cubit<GetTopSellingDrinksState> {
  GetTopSellingDrinksCubit(this.reportsRepo)
    : super(GetTopSellingDrinksInitial());

  final ReportRepo reportsRepo;

  Future<void> getTopSellingDrinks() async {
    emit(GetTopSellingDrinksLoading());

    try {
      final drinks = await reportsRepo.getTopSellingDrinks();
      final topThreeDrinks = await reportsRepo.getTopSellingDrinks(
        topThree: true,
      );
      emit(
        GetTopSellingDrinksSuccess(
          topSellingDrinks: drinks,
          topThreeDrinks: topThreeDrinks,
        ),
      );
    } catch (e) {
      emit(GetTopSellingDrinksError('Failed to get top selling drinks'));
    }
  }
}
