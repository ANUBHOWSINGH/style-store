
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/login_page.dart';
import 'features/auth/presentation/splash_screen.dart';
import 'features/products/presentation/pages.dart';
import 'features/watchlist/presentation/bloc.dart';
import 'features/cart/presentation/bloc.dart';
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const StyleStoreApp());
}

class StyleStoreApp extends StatelessWidget {
  const StyleStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistBloc>.value(
          value: sl<WatchlistBloc>()..add(const LoadWatchlist()),
        ),
        BlocProvider<CartBloc>.value(
          value: sl<CartBloc>()..add(const LoadCart()),
        ),
      ],
      child: MaterialApp(
        title: 'Style Store',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF7F5F0),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF173D2B),
            primary: const Color(0xFF173D2B),
            surface: const Color(0xFFF7F5F0),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF173D2B),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
        ),

        home: const SplashScreen(),
      ),
    );
  }
}
