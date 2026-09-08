import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  int _selectedPaymentMethod = 0;
  bool _isProcessing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _processOrder(CartProvider cart, LanguageProvider langProvider, Color primaryColor, Color cardBgColor) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final totalAmount = cart.totalAmount + (cart.totalAmount > 0 ? 2.50 : 0.0);
    cart.clear();

    setState(() => _isProcessing = false);

   
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: primaryColor,
                size: 52,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              langProvider.isMyanmar ? 'ဝယ်ယူမှု အောင်မြင်ပါသည်' : 'Order Confirmed!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              langProvider.isMyanmar
                  ? 'သင်၏ မှာယူမှုကို အောင်မြင်စွာ လက်ခံရရှိပါပြီ။ ကျေးဇူးတင်ပါသည်။'
                  : 'Thank you for your purchase! We have received your order.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor.withOpacity(0.6),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    langProvider.isMyanmar ? 'စုစုပေါင်း ကျသင့်ငွေ' : 'Total Paid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: Text(
                  langProvider.isMyanmar ? 'ပင်မစာမျက်နှာသို့' : 'BACK TO HOME',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final bgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF7F8FA);
    final primaryColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final cardBgColor = isDark ? const Color(0xFF181818) : Colors.white;
    final subtitleColor = isDark ? const Color(0xFFA0A0A0) : const Color(0xFF707070);
    final borderColor = primaryColor.withOpacity(0.08);

    final double subtotal = cart.totalAmount;
    final double shippingFee = subtotal > 0 ? 2.50 : 0.00;
    final double grandTotal = subtotal + shippingFee;
    final items = cart.items.values.toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: cardBgColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: primaryColor, size: 16),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          langProvider.isMyanmar ? 'ငွေချေစနစ်' : 'CHECKOUT',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    if (items.isNotEmpty) ...[
                      _buildHeaderSection(
                        step: '01',
                        title: langProvider.isMyanmar ? 'ဝယ်ယူမည့် ပစ္စည်းများ' : 'ITEMS IN ORDER',
                        color: subtitleColor,
                        primaryColor: primaryColor,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 72,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 72,
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cardBgColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: borderColor),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  items[index].product.image,
                                  fit: BoxFit.contain,
                                  errorBuilder: (ctx, _, __) => Icon(
                                    Icons.shopping_bag_outlined,
                                    color: subtitleColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                  
                    _buildHeaderSection(
                      step: '02',
                      title: langProvider.isMyanmar ? 'ပို့ဆောင်ရမည့် လိပ်စာ' : 'SHIPPING ADDRESS',
                      color: subtitleColor,
                      primaryColor: primaryColor,
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle(color: primaryColor, fontSize: 14),
                            decoration: _inputDecoration(
                              hintText: langProvider.isMyanmar ? 'အမည်' : 'Full Name',
                              icon: Icons.person_outline_rounded,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              hintColor: subtitleColor,
                            ),
                            validator: (val) => val == null || val.isEmpty
                                ? (langProvider.isMyanmar ? 'အမည် ဖြည့်သွင်းပါ' : 'Enter your name')
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: primaryColor, fontSize: 14),
                            decoration: _inputDecoration(
                              hintText: langProvider.isMyanmar ? 'ဖုန်းနံပါတ်' : 'Phone Number',
                              icon: Icons.phone_outlined,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              hintColor: subtitleColor,
                            ),
                            validator: (val) => val == null || val.isEmpty
                                ? (langProvider.isMyanmar ? 'ဖုန်းနံပါတ် ဖြည့်သွင်းပါ' : 'Enter phone number')
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _addressController,
                            maxLines: 2,
                            style: TextStyle(color: primaryColor, fontSize: 14),
                            decoration: _inputDecoration(
                              hintText: langProvider.isMyanmar ? 'နေရပ်လိပ်စာ' : 'Delivery Address',
                              icon: Icons.location_on_outlined,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              hintColor: subtitleColor,
                            ),
                            validator: (val) => val == null || val.isEmpty
                                ? (langProvider.isMyanmar ? 'လိပ်စာ ဖြည့်သွင်းပါ' : 'Enter address')
                                : null,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                   
                    _buildHeaderSection(
                      step: '03',
                      title: langProvider.isMyanmar ? 'ငွေချေမှု နည်းလမ်း' : 'PAYMENT METHOD',
                      color: subtitleColor,
                      primaryColor: primaryColor,
                    ),
                    const SizedBox(height: 12),

                    _buildPaymentOption(
                      index: 0,
                      title: langProvider.isMyanmar ? 'Mobile Wallet' : 'Mobile Wallet',
                      subtitle: 'KPay / WavePay',
                      icon: Icons.account_balance_wallet_outlined,
                      cardBgColor: cardBgColor,
                      borderColor: borderColor,
                      primaryColor: primaryColor,
                      subtitleColor: subtitleColor,
                    ),
                    const SizedBox(height: 10),

                    _buildPaymentOption(
                      index: 1,
                      title: langProvider.isMyanmar ? 'Credit / Debit Card' : 'Card Payment',
                      subtitle: 'Visa / Mastercard',
                      icon: Icons.credit_card_rounded,
                      cardBgColor: cardBgColor,
                      borderColor: borderColor,
                      primaryColor: primaryColor,
                      subtitleColor: subtitleColor,
                    ),
                    const SizedBox(height: 10),

                    _buildPaymentOption(
                      index: 2,
                      title: langProvider.isMyanmar ? 'ပစ္စည်းရောက်မှ ငွေချေမည်' : 'Cash on Delivery',
                      subtitle: 'Pay when delivered',
                      icon: Icons.local_shipping_outlined,
                      cardBgColor: cardBgColor,
                      borderColor: borderColor,
                      primaryColor: primaryColor,
                      subtitleColor: subtitleColor,
                    ),

                    const SizedBox(height: 24),

              
                    _buildHeaderSection(
                      step: '04',
                      title: langProvider.isMyanmar ? 'ကျသင့်ငွေ စာရင်း' : 'ORDER SUMMARY',
                      color: subtitleColor,
                      primaryColor: primaryColor,
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow(
                            langProvider.isMyanmar ? 'ပစ္စည်းဖိုး' : 'Subtotal',
                            '\$${subtotal.toStringAsFixed(2)}',
                            primaryColor,
                            subtitleColor,
                          ),
                          const SizedBox(height: 10),
                          _buildSummaryRow(
                            langProvider.isMyanmar ? 'ပို့ဆောင်ခ' : 'Delivery Fee',
                            '\$${shippingFee.toStringAsFixed(2)}',
                            primaryColor,
                            subtitleColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(height: 1, color: borderColor),
                          ),
                          _buildSummaryRow(
                            langProvider.isMyanmar ? 'စုစုပေါင်း' : 'Total',
                            '\$${grandTotal.toStringAsFixed(2)}',
                            primaryColor,
                            primaryColor,
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

    
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border(top: BorderSide(color: borderColor, width: 1.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        langProvider.isMyanmar ? 'စုစုပေါင်း' : 'TOTAL',
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${grandTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _isProcessing
                            ? null
                            : () => _processOrder(cart, langProvider, primaryColor, cardBgColor),
                        child: _isProcessing
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isDark ? Colors.black : Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    langProvider.isMyanmar ? 'အတည်ပြုမည်' : 'CONFIRM ORDER',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                      color: isDark ? Colors.black : Colors.white,
                                    ),
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
    );
  }

  Widget _buildHeaderSection({
    required String step,
    required String title,
    required Color color,
    required Color primaryColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            step,
            style: TextStyle(
              color: primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    required Color borderColor,
    required Color primaryColor,
    required Color hintColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: hintColor.withOpacity(0.6), fontSize: 13),
      prefixIcon: Icon(icon, color: primaryColor.withOpacity(0.6), size: 18),
      filled: true,
      fillColor: primaryColor.withOpacity(0.03),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color cardBgColor,
    required Color borderColor,
    required Color primaryColor,
    required Color subtitleColor,
  }) {
    final isSelected = _selectedPaymentMethod == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? primaryColor : borderColor,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withOpacity(0.1) : primaryColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: primaryColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? primaryColor : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? primaryColor : borderColor,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color primaryColor, Color textColor, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: primaryColor,
            fontSize: isBold ? 18 : 13,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
          ),
        ),
      ],
    );
  }
}