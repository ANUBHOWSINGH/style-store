
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../injection_container.dart';
import '../../cart/presentation/bloc.dart';
import '../domain/entities.dart';
import 'bloc.dart';
import 'payment_success_page.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentBloc>(),
      child: const _CheckoutView(),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          final result = state.result;

          context.read<CartBloc>().add(const ClearCart());

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => PaymentSuccessPage(result: result),
            ),
          );
        }

        if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, paymentState) {
        final cartState = context.watch<CartBloc>().state;

        if (cartState is! CartLoaded) {
          return Scaffold(
            backgroundColor: AppColors.cream,
            appBar: _buildAppBar(),
            body: const Center(
              child: CircularProgressIndicator(
                color: AppColors.forestGreen,
              ),
            ),
          );
        }

        final cart = cartState.cart;

        if (cart.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.cream,
            appBar: _buildAppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _iconCircle(Icons.shopping_bag_outlined),
                    const SizedBox(height: 22),
                    const Text(
                      'Nothing to checkout',
                      style: AppTextStyles.pageTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your shopping bag is empty. Explore the collection '
                          'and find something you love.',
                      style: AppTextStyles.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('BACK TO SHOPPING'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final isLoading = paymentState is PaymentLoading;

        return Scaffold(
          backgroundColor: AppColors.cream,
          appBar: _buildAppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    children: [
                      const Text(
                        'ALMOST YOURS',
                        style: AppTextStyles.eyebrow,
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Review your order',
                        style: AppTextStyles.pageTitle,
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Make sure everything looks right before you pay.',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: 24),

                      // Order items section
                      _sectionHeading(
                        'YOUR ITEMS',
                        '${cart.totalItems} item${cart.totalItems == 1 ? '' : 's'}',
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColors.inputBorder,
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(14),
                          itemCount: cart.items.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 26,
                            color: AppColors.inputBorder,
                          ),
                          itemBuilder: (context, index) {
                            final item = cart.items[index];

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    item.product.imageUrl,
                                    width: 78,
                                    height: 94,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        width: 78,
                                        height: 94,
                                        color: AppColors.cream,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.checkroom_outlined,
                                          size: 32,
                                          color: AppColors.forestGreen,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 14),
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
                                      const SizedBox(height: 5),
                                      Text(
                                        item.product.subtitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.productSubtitle,
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.cream,
                                          borderRadius:
                                          BorderRadius.circular(7),
                                        ),
                                        child: Text(
                                          'Qty: ${item.quantity}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '₹${item.totalPrice.toStringAsFixed(2)}',
                                  style: AppTextStyles.productPrice,
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Price breakdown
                      _sectionHeading('PRICE DETAILS', 'INR'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColors.inputBorder,
                          ),
                        ),
                        child: Column(
                          children: [
                            _priceRow(
                              'Items (${cart.totalItems})',
                              '₹${cart.totalAmount.toStringAsFixed(2)}',
                            ),
                            const SizedBox(height: 14),
                            _priceRow(
                              'Delivery',
                              'FREE',
                              valueColor: AppColors.forestGreen,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Divider(
                                color: AppColors.inputBorder,
                              ),
                            ),
                            _priceRow(
                              'Total payable',
                              '₹${cart.totalAmount.toStringAsFixed(2)}',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Demo payment notice
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.forestGreen.withValues(
                            alpha: 0.06,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.forestGreen.withValues(
                              alpha: 0.15,
                            ),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              color: AppColors.forestGreen,
                              size: 23,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Demo payment',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: AppColors.forestGreen,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'This assessment uses a simulated payment '
                                        'flow. No real payment will be collected.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Sticky payment action
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: const Border(
                      top: BorderSide(
                        color: AppColors.inputBorder,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.forestGreen.withValues(
                          alpha: 0.04,
                        ),
                        blurRadius: 15,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TOTAL AMOUNT',
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '₹${cart.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.forestGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 54,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.forestGreen,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor:
                                AppColors.inputBorder,
                                disabledForegroundColor:
                                AppColors.textSecondary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                context.read<PaymentBloc>().add(
                                  InitiatePayment(
                                    cart.totalAmount,
                                  ),
                                );
                              },
                              child: isLoading
                                  ? const SizedBox(
                                height: 23,
                                width: 23,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                                  : const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PAY NOW',
                                    style: AppTextStyles.button,
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: AppColors.forestGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'CHECKOUT',
        style: AppTextStyles.appBarTitle,
      ),
      leading: Builder(
        builder: (context) => IconButton(
          tooltip: 'Go back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  static Widget _iconCircle(IconData icon) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.card,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Icon(
        icon,
        size: 46,
        color: AppColors.forestGreen,
      ),
    );
  }

  static Widget _sectionHeading(String title, String trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          trailing,
          style: AppTextStyles.productSubtitle,
        ),
      ],
    );
  }

  static Widget _priceRow(
      String label,
      String value, {
        bool isTotal = false,
        Color? valueColor,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 13,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ??
                (isTotal
                    ? AppColors.forestGreen
                    : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
