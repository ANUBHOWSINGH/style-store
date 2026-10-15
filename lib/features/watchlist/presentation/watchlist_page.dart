
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../products/presentation/pages.dart';
import 'bloc.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: AppColors.forestGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'MY WATCHLIST',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is! WatchlistLoaded) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.forestGreen,
              ),
            );
          }

          if (state.products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.inputBorder,
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 48,
                        color: AppColors.forestGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Your watchlist is empty',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.pageTitle,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Save products you love to find them here.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.forestGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'EXPLORE PRODUCTS',
                          style: AppTextStyles.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.products.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.57,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: state.products[index],
              );
            },
          );
        },
      ),
    );
  }
}
