import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = false;
  String _selectedCategory = 'All';

  List<Product> get products {
    if (_selectedCategory == 'All') {
      return _products;
    }
    return _products.where((p) => p.category == _selectedCategory).toList();
  }

  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    return ['All', ...cats];
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}