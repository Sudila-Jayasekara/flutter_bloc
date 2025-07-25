part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromCartEvent extends CartEvent{
  final ProductDataModel removedProduct;

  CartRemoveFromCartEvent({required this.removedProduct});
}