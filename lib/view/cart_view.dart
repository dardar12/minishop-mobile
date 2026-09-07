import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;
 final bgColor = isDark ? Colors.black : Colors.white;
    final primaryColor = isDark ? Colors.white : Colors.black;
    final secondaryColor = isDark ? Colors.black : Colors.white;
    final cardBgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final subtitleColor = isDark ? Colors.grey.shade400 : const Color(0xFF666666);
    final borderColor = primaryColor.withOpacity(0.15);

    final items = cart.items.values.toList();

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
          langProvider.isMyanmar ? 'ဈေးဝယ်အိတ်' : 'SHOPPING CART',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          if (items.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: primaryColor),
              onPressed: () {
                cart.clear();
              },
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 1.5),
                    ),
                    child: Center(
                      child: CustomPaint(
                        size: const Size(60, 60),
                        painter: _EmptyCartPainter(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    langProvider.isMyanmar ? 'ဈေးဝယ်အိတ်ထဲတွင် ဘာမျှမရှိသေးပါ' : 'Your cart is empty',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    langProvider.isMyanmar
                        ? 'ပစ္စည်းများကို ရှာဖွေပြီး ဈေးဝယ်အိတ်ထဲသို့ ထည့်သွင်းပါ'
                        : 'Explore products and add items to your cart',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor, width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black26 : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: borderColor, width: 1),
                              ),
                              child: Image.network(
                                item.product.image,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image_not_supported_outlined, color: subtitleColor),
                              ),
                            ),
                            const SizedBox(width: 14),
 Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '\$${item.product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: borderColor, width: 1.2),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => cart.removeSingleItem(item.product.id),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(Icons.remove, size: 16, color: primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      '${item.quantity}',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => cart.addToCart(item.product),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(Icons.add, size: 16, color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                 Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                    border: Border(top: BorderSide(color: borderColor, width: 1.5)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            langProvider.isMyanmar ? 'စုစုပေါင်း' : 'TOTAL',
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            '\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: primaryColor,
                                content: Text(
                                  langProvider.isMyanmar
                                      ? 'ဝယ်ယူမှု အောင်မြင်ပါသည်။'
                                      : 'Checkout feature coming soon!',
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                langProvider.isMyanmar ? 'ငွေချေမည်' : 'CHECKOUT',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
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

class _EmptyCartPainter extends CustomPainter {
  final Color color;

  _EmptyCartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
canvas.drawLine(Offset(w * 0.1, h * 0.25), Offset(w * 0.25, h * 0.25), paint);
    canvas.drawLine(Offset(w * 0.25, h * 0.25), Offset(w * 0.35, h * 0.65), paint);

    final basketPath = Path()
      ..moveTo(w * 0.25, h * 0.32)
      ..lineTo(w * 0.85, h * 0.32)
      ..lineTo(w * 0.75, h * 0.65)
      ..lineTo(w * 0.35, h * 0.65);
    canvas.drawPath(basketPath, paint);
 canvas.drawLine(Offset(w * 0.4, h * 0.42), Offset(w * 0.7, h * 0.55), paint);
 canvas.drawCircle(Offset(w * 0.42, h * 0.78), 5, paint);
    canvas.drawCircle(Offset(w * 0.68, h * 0.78), 5, paint);
  }

  @override
  bool shouldRepaint(covariant _EmptyCartPainter oldDelegate) => oldDelegate.color != color;
}