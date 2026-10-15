
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: Colors.white,
  );

  static const TextStyle eyebrow = TextStyle(
    fontSize: 12,
    letterSpacing: 2,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle pageTitle = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle productName = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle productSubtitle = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
  );

  static const TextStyle productPrice = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.forestGreen,
  );

  static const TextStyle button = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.8,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle brandTitle = TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontWeight: FontWeight.w600,
    letterSpacing: 3,
  );

  static const TextStyle brandTagline = TextStyle(
    color: AppColors.softGold,
    fontSize: 10,
    letterSpacing: 2,
  );

  static const TextStyle errorMessage = TextStyle(
    color: AppColors.error,
    fontSize: 13,
  );

  static const TextStyle footer = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13,
    fontStyle: FontStyle.italic,
  );

}
