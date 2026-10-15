// A cart item contains a product and its quantity
import 'package:equatable/equatable.dart';

import '../../products/domain/entities.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product.id, quantity];
}

class CartEntity extends Equatable {
  final List<CartItemEntity> items;

  const CartEntity({this.items = const []});

  double get totalAmount =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items];
}
