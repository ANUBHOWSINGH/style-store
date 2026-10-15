
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../injection_container.dart';
import '../../cart/presentation/bloc.dart';
import '../../cart/presentation/cart_page.dart';
import '../../watchlist/presentation/bloc.dart';
import '../../watchlist/presentation/watchlist_page.dart';
import '../domain/entities.dart';
import 'bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsBloc>()..add(const LoadProducts()),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

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
          'STYLE STORE',
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: false,
        actions: [
          // Watchlist button
          IconButton(
            tooltip: 'My Watchlist',
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const WatchlistPage(),
                ),
              );
            },
          ),

          // Shopping bag with live cart count badge
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              final int cartCount = cartState is CartLoaded
                  ? cartState.cart.totalItems
                  : 0;

              return IconButton(
                tooltip: 'Shopping Bag ($cartCount items)',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CartPage(),
                    ),
                  );
                },
                icon: SizedBox(
                  width: 38,
                  height: 38,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 27,
                        ),
                      ),
                      if (cartCount > 0)
                        Positioned(
                          top: 3,
                          right:3,
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.forestGreen,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              cartCount > 99 ? '99+' : '$cartCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsInitial || state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.forestGreen,
              ),
            );
          }

          if (state is ProductsFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forestGreen,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.read<ProductsBloc>().add(
                          const LoadProducts(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProductsEmpty) {
            return const Center(
              child: Text(
                'No products available.',
                style: AppTextStyles.body,
              ),
            );
          }

          if (state is ProductsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 5),
                  child: Text(
                    'NEW COLLECTION',
                    style: AppTextStyles.eyebrow,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Find your style.',
                    style: AppTextStyles.pageTitle,
                  ),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Everyday essentials, made for you.',
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
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
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shadowColor: AppColors.forestGreen.withValues(alpha: 0.08),
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppColors.inputBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: AppColors.cream,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.checkroom_outlined,
                        size: 48,
                        color: AppColors.forestGreen,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;

                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.forestGreen,
                      ),
                    );
                  },
                ),

                // Watchlist favorite button
                Positioned(
                  top: 7,
                  right: 7,
                  child: CircleAvatar(
                    backgroundColor: AppColors.card,
                    radius: 18,
                    child: BlocBuilder<WatchlistBloc, WatchlistState>(
                      builder: (context, state) {
                        final isSaved = state is WatchlistLoaded &&
                            state.products.any(
                                  (item) => item.id == product.id,
                            );

                        return IconButton(
                          tooltip: isSaved
                              ? 'Remove from watchlist'
                              : 'Add to watchlist',
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                          icon: Icon(
                            isSaved
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isSaved
                                ? AppColors.error
                                : AppColors.forestGreen,
                          ),
                          onPressed: () {
                            final bloc = context.read<WatchlistBloc>();

                            if (isSaved) {
                              bloc.add(
                                RemoveFromWatchlist(product.id),
                              );
                            } else {
                              bloc.add(
                                AddToWatchlist(product),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.productName,
                ),
                const SizedBox(height: 4),
                Text(
                  product.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.productSubtitle,
                ),
                const SizedBox(height: 7),
                Text(
                  '₹${product.price.toStringAsFixed(0)}',
                  style: AppTextStyles.productPrice,
                ),
                const SizedBox(height: 9),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.forestGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      context.read<CartBloc>().add(
                        AddToCart(product),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.forestGreen,
                          content: Text(
                            '${product.name} added to your bag',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text(
                      'ADD TO BAG',
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
