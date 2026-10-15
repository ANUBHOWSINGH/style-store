// This loads products from the local JSON asset.
import 'dart:convert';

import 'package:flutter/services.dart';

import 'models.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/products.json',
    );

    final decoded = jsonDecode(jsonString);

    if (decoded is! List) {
      throw const FormatException(
        'Products JSON must contain a list.',
      );
    }

    return decoded.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Invalid product record in JSON.',
        );
      }

      return ProductModel.fromJson(item);
    }).toList();
  }
}
