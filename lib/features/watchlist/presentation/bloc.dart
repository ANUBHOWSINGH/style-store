// The BLoC coordinates events and states
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/domain/entities.dart';
import '../domain/usecases.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {
  const LoadWatchlist();
}

class AddToWatchlist extends WatchlistEvent {
  final ProductEntity product;

  const AddToWatchlist(this.product);

  @override
  List<Object?> get props => [product.id];
}

class RemoveFromWatchlist extends WatchlistEvent {
  final String productId;

  const RemoveFromWatchlist(this.productId);

  @override
  List<Object?> get props => [productId];
}

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();
}

class WatchlistLoaded extends WatchlistState {
  final List<ProductEntity> products;

  const WatchlistLoaded(this.products);

  @override
  List<Object?> get props =>
      [products.map((product) => product.id).toList()];
}

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistUseCase getWatchlist;
  final AddToWatchlistUseCase addToWatchlist;
  final RemoveFromWatchlistUseCase removeFromWatchlist;

  WatchlistBloc({
    required this.getWatchlist,
    required this.addToWatchlist,
    required this.removeFromWatchlist,
  }) : super(const WatchlistInitial()) {
    on<LoadWatchlist>((event, emit) {
      _emitCurrentWatchlist(emit);
    });

    on<AddToWatchlist>((event, emit) {
      addToWatchlist(event.product);
      _emitCurrentWatchlist(emit);
    });

    on<RemoveFromWatchlist>((event, emit) {
      removeFromWatchlist(event.productId);
      _emitCurrentWatchlist(emit);
    });
  }

  void _emitCurrentWatchlist(Emitter<WatchlistState> emit) {
    emit(WatchlistLoaded(getWatchlist()));
  }
}
