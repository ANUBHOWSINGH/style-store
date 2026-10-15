// Register dependencies
import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources.dart';
import 'features/auth/data/repositories.dart';
import 'features/auth/domain/repositories.dart';
import 'features/auth/domain/usecases.dart';
import 'features/auth/presentation/bloc.dart';
import 'features/cart/data/datasources.dart';
import 'features/cart/data/repositories.dart';
import 'features/cart/domain/repositories.dart';
import 'features/cart/domain/usecases.dart';
import 'features/cart/presentation/bloc.dart';
import 'features/payment/data/datasources.dart';
import 'features/payment/data/repositories.dart';
import 'features/payment/domain/repositories.dart';
import 'features/payment/domain/usecases.dart';
import 'features/payment/presentation/bloc.dart';
import 'features/products/data/datasources.dart';
import 'features/products/data/repositories.dart';
import 'features/products/domain/repositories.dart';
import 'features/products/domain/usecases.dart';
import 'features/products/presentation/bloc.dart';
import 'features/watchlist/data/datasources.dart';
import 'features/watchlist/data/repositories.dart';
import 'features/watchlist/domain/repositories.dart';
import 'features/watchlist/domain/usecases.dart';
import 'features/watchlist/presentation/bloc.dart';

final sl = GetIt.instance;

void initDependencies() {
  // Data source
  sl.registerLazySingleton<ProductLocalDataSource>(
        () => ProductLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      localDataSource: sl<ProductLocalDataSource>(),
    ),
  );

  // Use case
  sl.registerLazySingleton<GetProductsUseCase>(
        () => GetProductsUseCase(
      sl<ProductRepository>(),
    ),
  );
  sl.registerFactory<ProductsBloc>(
        () => ProductsBloc(
      getProductsUseCase: sl<GetProductsUseCase>(),
    ),
  );

  // Watch list

  sl.registerLazySingleton<WatchlistLocalDataSource>(
        () => WatchlistLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<WatchlistRepository>(
        () => WatchlistRepositoryImpl(
      dataSource: sl<WatchlistLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetWatchlistUseCase>(
        () => GetWatchlistUseCase(sl<WatchlistRepository>()),
  );

  sl.registerLazySingleton<AddToWatchlistUseCase>(
        () => AddToWatchlistUseCase(sl<WatchlistRepository>()),
  );

  sl.registerLazySingleton<RemoveFromWatchlistUseCase>(
        () => RemoveFromWatchlistUseCase(sl<WatchlistRepository>()),
  );

  sl.registerLazySingleton<WatchlistBloc>(
        () => WatchlistBloc(
      getWatchlist: sl<GetWatchlistUseCase>(),
      addToWatchlist: sl<AddToWatchlistUseCase>(),
      removeFromWatchlist: sl<RemoveFromWatchlistUseCase>(),
    ),
  );

//   Cart

  // Cart data source
  sl.registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(),
  );

  // Cart repository
  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(
      dataSource: sl<CartLocalDataSource>(),
    ),
  );

  // Cart use cases
  sl.registerLazySingleton<GetCartUseCase>(
        () => GetCartUseCase(sl<CartRepository>()),
  );

  sl.registerLazySingleton<AddToCartUseCase>(
        () => AddToCartUseCase(sl<CartRepository>()),
  );

  sl.registerLazySingleton<RemoveFromCartUseCase>(
        () => RemoveFromCartUseCase(sl<CartRepository>()),
  );

  sl.registerLazySingleton<UpdateCartQuantityUseCase>(
        () => UpdateCartQuantityUseCase(sl<CartRepository>()),
  );

  sl.registerLazySingleton<ClearCartUseCase>(
        () => ClearCartUseCase(sl<CartRepository>()),
  );

  // One shared Cart BLoC
  sl.registerLazySingleton<CartBloc>(
        () => CartBloc(
      getCart: sl<GetCartUseCase>(),
      addToCart: sl<AddToCartUseCase>(),
      removeFromCart: sl<RemoveFromCartUseCase>(),
      updateCartQuantity: sl<UpdateCartQuantityUseCase>(),
      clearCart: sl<ClearCartUseCase>(),
    ),
  );
//   Payment

  sl.registerLazySingleton<PaymentLocalDataSource>(
        () => PaymentLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(
      dataSource: sl<PaymentLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<ProcessDummyPaymentUseCase>(
        () => ProcessDummyPaymentUseCase(
      sl<PaymentRepository>(),
    ),
  );

  sl.registerFactory<PaymentBloc>(
        () => PaymentBloc(
      processDummyPayment: sl<ProcessDummyPaymentUseCase>(),
    ),
  );
// Auth


  // Authentication data source
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(),
  );

  // Authentication repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      dataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // Login use case
  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl<AuthRepository>()),
  );

  // Login BLoC
  sl.registerFactory<LoginBloc>(
        () => LoginBloc(
      loginUseCase: sl<LoginUseCase>(),
    ),
  );


}
