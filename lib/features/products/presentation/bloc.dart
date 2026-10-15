
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities.dart';
import '../domain/usecases.dart';



// EVENTS
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {
  const LoadProducts();
}

// STATES
abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsEmpty extends ProductsState {
  const ProductsEmpty();
}

class ProductsFailure extends ProductsState {
  final String message;

  const ProductsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// BLOC
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;

  ProductsBloc({
    required this.getProductsUseCase,
  }) : super(const ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductsState> emit,
      ) async {
    emit(const ProductsLoading());

    try {
      final products = await getProductsUseCase();

      if (products.isEmpty) {
        emit(const ProductsEmpty());
      } else {
        emit(ProductsLoaded(products));
      }
    } catch (error) {
      emit(ProductsFailure(error.toString()));
    }
  }
}
