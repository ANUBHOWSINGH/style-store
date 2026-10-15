
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../domain/entities.dart';

class PaymentSuccessPage extends StatelessWidget {
  final PaymentResultEntity result;

  const PaymentSuccessPage({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Brand
                const Text(
                  'STYLE STORE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.5,
                    color: AppColors.forestGreen,
                  ),
                ),
                const SizedBox(height: 32),

                // Success illustration
                Container(
                  height: 118,
                  width: 118,
                  decoration: BoxDecoration(
                    color: AppColors.forestGreen.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.forestGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 54,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Success message
                const Text(
                  'ORDER CONFIRMED',
                  style: AppTextStyles.eyebrow,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Thank you for\nyour purchase!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 31,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your style journey starts here. Thank you for '
                      'choosing Style Store.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 30),

                // Order receipt card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.inputBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.forestGreen.withValues(
                          alpha: 0.04,
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            color: AppColors.forestGreen,
                            size: 21,
                          ),
                          SizedBox(width: 9),
                          Text(
                            'PAYMENT RECEIPT',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      const Text(
                        'AMOUNT PAID',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '₹${result.paidAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      const SizedBox(height: 0),
                      const Divider(
                        color: AppColors.inputBorder,
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'ORDER ID',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                              result.orderId,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Copy order ID',
                            onPressed: () {
                              // SelectableText lets users select and copy
                              // the order ID without extra dependencies.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Press and hold the order ID to copy it.',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.copy_outlined,
                              size: 18,
                              color: AppColors.forestGreen,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Continue shopping
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.forestGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CONTINUE SHOPPING',
                          style: AppTextStyles.button,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'THANK YOU FOR SHOPPING WITH US',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
