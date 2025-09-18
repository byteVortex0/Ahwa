part of 'get_top_selling_drinks_cubit.dart';

@immutable
sealed class GetTopSellingDrinksState {}

final class GetTopSellingDrinksInitial extends GetTopSellingDrinksState {}

final class GetTopSellingDrinksLoading extends GetTopSellingDrinksState {}

final class GetTopSellingDrinksSuccess extends GetTopSellingDrinksState {
  final List<ReportModel> topSellingDrinks;
  final List<ReportModel> topThreeDrinks;

  GetTopSellingDrinksSuccess({
    required this.topSellingDrinks,
    required this.topThreeDrinks,
  });
}

final class GetTopSellingDrinksError extends GetTopSellingDrinksState {
  final String errorMessage;
  GetTopSellingDrinksError(this.errorMessage);
}
