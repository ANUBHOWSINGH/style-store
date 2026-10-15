
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../payment/presentation/checkout_page.dart';
import '../domain/entities.dart';
import 'bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          'MY BAG',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.forestGreen,
              ),
            );
          }

          if (state is CartFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ),
            );
          }

          if (state is! CartLoaded) {
            return const SizedBox.shrink();
          }

          final CartEntity cart = state.cart;

          if (cart.isEmpty) {
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
                        Icons.shopping_bag_outlined,
                        size: 48,
                        color: AppColors.forestGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Your bag is empty',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.pageTitle,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add something you love to get started.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
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

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];

                    return Card(
                      color: AppColors.card,
                      elevation: 1,
                      shadowColor:
                      AppColors.forestGreen.withValues(alpha: 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: AppColors.inputBorder,
                          width: 0.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.product.imageUrl,
                                width: 90,
                                height: 112,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    width: 90,
                                    height: 112,
                                    color: AppColors.cream,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.checkroom_outlined,
                                      size: 36,
                                      color: AppColors.forestGreen,
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, progress) {
                                  if (progress == null) return child;

                                  return Container(
                                    width: 90,
                                    height: 112,
                                    color: AppColors.cream,
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.forestGreen,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.productName,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.product.subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.productSubtitle,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '₹${item.totalPrice.toStringAsFixed(2)}',
                                    style: AppTextStyles.productPrice,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      IconButton(
                                        tooltip: 'Decrease quantity',
                                        visualDensity:
                                        VisualDensity.compact,
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                            DecreaseQuantity(
                                              item.product.id,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: AppColors.forestGreen,
                                        ),
                                      ),
                                      Text(
                                        '${item.quantity}',
                                        style: AppTextStyles.body,
                                      ),
                                      IconButton(
                                        tooltip: 'Increase quantity',
                                        visualDensity:
                                        VisualDensity.compact,
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                            IncreaseQuantity(
                                              item.product.id,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: AppColors.forestGreen,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        tooltip: 'Remove product',
                                        visualDensity:
                                        VisualDensity.compact,
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                            RemoveFromCart(
                                              item.product.id,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Order summary and checkout
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.forestGreen.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total items',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            '${cart.totalItems}',
                            style: AppTextStyles.productName,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: AppColors.inputBorder),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total amount',
                            style: AppTextStyles.productName,
                          ),
                          Text(
                            '₹${cart.totalAmount.toStringAsFixed(2)}',
                            style: AppTextStyles.productPrice,
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CheckoutPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'PROCEED TO CHECKOUT',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
