import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => List.unmodifiable(_favoriteProducts);

  int get itemCount => _favoriteProducts.length;

  bool isFavorite(int productId) {
    return _favoriteProducts.any((product) => product.id == productId);
  }

  void toggleFavorite(Product product) {
    final isExisting = isFavorite(product.id);
    if (isExisting) {
      _favoriteProducts.removeWhere((item) => item.id == product.id);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }

  void addFavorite(Product product) {
    if (!isFavorite(product.id)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(int productId) {
    _favoriteProducts.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteProducts.clear();
    notifyListeners();
  }
}
