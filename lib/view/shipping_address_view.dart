import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class ShippingAddressView extends StatefulWidget {
  const ShippingAddressView({super.key});

  @override
  State<ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<ShippingAddressView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Dar Dar');
  final _phoneController = TextEditingController(text: '+95 9 123 456 789');
  final _addressController = TextEditingController(
      text: 'No. 123, Pyay Road, Kamayut Township, Yangon');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final bgColor = isDark ? const Color(0xFF101010) : const Color(0xFFFAF7F5);
    final primaryColor = isDark ? Colors.white : const Color(0xFF2C221E);
    final secondaryColor = isDark ? Colors.black : Colors.white;
    final cardBgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final subtitleColor =
        isDark ? Colors.grey.shade400 : const Color(0xFF8C827A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: primaryColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          langProvider.isMyanmar ? 'ပို့ဆောင်ရမည့် လိပ်စာ' : 'SHIPPING ADDRESS',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                langProvider.isMyanmar
                    ? 'ပစ္စည်းပို့ဆောင်ရမည့် အချက်အလက်များ'
                    : 'Delivery Details',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),

              // Full Name Field
              _buildInputField(
                label: langProvider.isMyanmar ? 'အမည်' : 'Full Name',
                controller: _nameController,
                icon: Icons.person_outline,
                primaryColor: primaryColor,
                cardBgColor: cardBgColor,
                subtitleColor: subtitleColor,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              _buildInputField(
                label: langProvider.isMyanmar ? 'ဖုန်းနံပါတ်' : 'Phone Number',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                primaryColor: primaryColor,
                cardBgColor: cardBgColor,
                subtitleColor: subtitleColor,
              ),
              const SizedBox(height: 16),

              // Detailed Address Field
              _buildInputField(
                label: langProvider.isMyanmar ? 'လိပ်စာ' : 'Address',
                controller: _addressController,
                icon: Icons.location_on_outlined,
                maxLines: 3,
                primaryColor: primaryColor,
                cardBgColor: cardBgColor,
                subtitleColor: subtitleColor,
              ),

              const Spacer(),

              // Save Address Button
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
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: primaryColor,
                          content: Text(
                            langProvider.isMyanmar
                                ? 'လိပ်စာ အောင်မြင်စွာ သိမ်းဆည်းပြီးပါပြီ'
                                : 'Address saved successfully!',
                            style: TextStyle(color: secondaryColor),
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    langProvider.isMyanmar ? 'သိမ်းဆည်းမည်' : 'SAVE ADDRESS',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required Color primaryColor,
    required Color cardBgColor,
    required Color subtitleColor,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: subtitleColor.withOpacity(0.15)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: primaryColor, fontSize: 14),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(icon, color: subtitleColor, size: 20),
          labelText: label,
          labelStyle: TextStyle(color: subtitleColor, fontSize: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
}