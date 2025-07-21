part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartActionState extends CartState{}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState{}

final class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}

final class CartErrorState extends CartState{}

