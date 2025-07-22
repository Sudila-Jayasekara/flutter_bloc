part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState{
  final List<ProductDataModel> products;
  final List<ProductDataModel> cartItems;

  HomeLoadedSuccessState({required this.products, required this.cartItems});
}

final class HomeErrorState extends HomeState{}


//action states not building ui
final class HomeNavigateToWishlistPageActionState extends HomeActionState {}

final class HomeNavigateToCartPageActionState extends HomeActionState {}

final class HomeProductWishlistButtonClickedActionState extends HomeActionState {}

final class HomeProductCartButtonClickedActionState extends HomeActionState {}