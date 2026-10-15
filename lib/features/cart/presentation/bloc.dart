
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/domain/entities.dart';
import '../domain/entities.dart';
import '../domain/usecases.dart';

// Events
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddToCart extends CartEvent {
  final ProductEntity product;

  const AddToCart(this.product);

  @override
  List<Object?> get props => [product.id];
}

class RemoveFromCart extends CartEvent {
  final String productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

class IncreaseQuantity extends CartEvent {
  final String productId;

  const IncreaseQuantity(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DecreaseQuantity extends CartEvent {
  final String productId;

  const DecreaseQuantity(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearCart extends CartEvent {
  const ClearCart();
}

// States
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final CartEntity cart;

  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartFailure extends CartState {
  final String message;

  const CartFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCart;
  final AddToCartUseCase addToCart;
  final RemoveFromCartUseCase removeFromCart;
  final UpdateCartQuantityUseCase updateCartQuantity;
  final ClearCartUseCase clearCart;

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartQuantity,
    required this.clearCart,
  }) : super(const CartInitial()) {
    on<LoadCart>((event, emit) {
      _emitCart(emit);
    });

    on<AddToCart>((event, emit) {
      addToCart(event.product);
      _emitCart(emit);
    });

    on<RemoveFromCart>((event, emit) {
      removeFromCart(event.productId);
      _emitCart(emit);
    });

    on<IncreaseQuantity>((event, emit) {
      final cart = getCart();
      final item = cart.items.where(
            (item) => item.product.id == event.productId,
      );

      if (item.isNotEmpty) {
        updateCartQuantity(
          event.productId,
          item.first.quantity + 1,
        );
      }

      _emitCart(emit);
    });

    on<DecreaseQuantity>((event, emit) {
      final cart = getCart();
      final item = cart.items.where(
            (item) => item.product.id == event.productId,
      );

      if (item.isNotEmpty) {
        updateCartQuantity(
          event.productId,
          item.first.quantity - 1,
        );
      }

      _emitCart(emit);
    });

    on<ClearCart>((event, emit) {
      clearCart();
      _emitCart(emit);
    });
  }

  void _emitCart(Emitter<CartState> emit) {
    emit(CartLoaded(getCart()));
  }
}

