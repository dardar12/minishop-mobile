import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: primaryColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          langProvider.isMyanmar ? 'အသေးစိတ်' : 'DETAILS',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: borderColor, width: 1.5),
                    ),
                    child: Center(
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported_outlined, size: 48, color: subtitleColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    product.title,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
 Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Divider(color: borderColor, thickness: 1),
                  const SizedBox(height: 16),

                  Text(
                    langProvider.isMyanmar ? 'အကြောင်းအရာ' : 'DESCRIPTION',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: TextStyle(
                      color: primaryColor.withOpacity(0.8),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(top: BorderSide(color: borderColor, width: 1.5)),
            ),
            child: Consumer<CartProvider>(
              builder: (context, cart, _) => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: secondaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    cart.addToCart(product);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: primaryColor,
                        content: Text(
                          langProvider.isMyanmar
                              ? '${product.title} ကို ဈေးဝယ်အိတ်ထဲ ထည့်ပြီးပါပြီ'
                              : 'Added to cart successfully!',
                          style: TextStyle(color: secondaryColor),
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: secondaryColor, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        langProvider.isMyanmar ? 'ဈေးဝယ်အိတ်ထဲထည့်မည်' : 'ADD TO CART',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}