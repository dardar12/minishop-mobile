import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import 'product_detail_view.dart';
import 'cart_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // Black & White Color Palette
    final bgColor = isDark ? Colors.black : Colors.white;
    final primaryColor = isDark ? Colors.white : Colors.black;
    final secondaryColor = isDark ? Colors.black : Colors.white;
    final cardBgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final subtitleColor = isDark ? Colors.grey.shade400 : const Color(0xFF666666);
    final borderColor = primaryColor.withOpacity(0.15);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          'MINISHOP',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
        actions: [
          // Language Toggle
          InkWell(
            onTap: () => langProvider.toggleLanguage(),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                langProvider.isMyanmar ? 'မြန်မာ' : 'EN',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Theme Switcher
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: primaryColor,
              size: 22,
            ),
            onPressed: () => themeProvider.toggleTheme(!isDark),
          ),

          Consumer<CartProvider>(
            builder: (context, cart, child) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_bag_outlined, color: primaryColor, size: 24),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartView()),
                    );
                  },
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cart.itemCount}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: productProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 8),

                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: productProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = productProvider.categories[index];
                      final isSelected = category == productProvider.selectedCategory;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => productProvider.selectCategory(category),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? primaryColor : borderColor,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category.toUpperCase(),
                                style: TextStyle(
                                  color: isSelected ? secondaryColor : subtitleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                 Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) {
                      final product = productProvider.products[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailView(product: product),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image Container
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.black26 : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Icon(Icons.image_not_supported_outlined, color: subtitleColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Product Title
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Consumer<CartProvider>(
                                      builder: (context, cart, _) => InkWell(
                                        onTap: () {
                                          cart.addToCart(product);
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: primaryColor,
                                              content: Text(
                                                '${product.title} added to cart!',
                                                style: TextStyle(color: secondaryColor, fontSize: 12),
                                              ),
                                              duration: const Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: secondaryColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}