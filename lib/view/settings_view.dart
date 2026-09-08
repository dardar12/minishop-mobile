import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final bgColor = isDark ? const Color(0xFF101010) : const Color(0xFFFAF7F5);
    final primaryColor = isDark ? Colors.white : const Color(0xFF2C221E);
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
          langProvider.isMyanmar ? 'ပြင်ဆင်ချက်များ' : 'SETTINGS',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // APPEARANCE SECTION
          _buildSectionHeader(
            langProvider.isMyanmar ? 'ရုပ်ထွက် ပုံစံ' : 'APPEARANCE',
            subtitleColor,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: subtitleColor.withOpacity(0.15)),
            ),
            child: Column(
              children: [
                // Dark Mode Switch
                SwitchListTile(
                  activeColor: primaryColor,
                  secondary: Icon(
                    isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    color: primaryColor,
                  ),
                  title: Text(
                    langProvider.isMyanmar ? 'အမှောင် ပုံစံ' : 'Dark Mode',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                  value: isDark,
                  onChanged: (val) => themeProvider.toggleTheme(val),
                ),
                Divider(height: 1, color: subtitleColor.withOpacity(0.15)),

                // Language Switch
                ListTile(
                  leading: Icon(Icons.language_rounded, color: primaryColor),
                  title: Text(
                    langProvider.isMyanmar ? 'ဘာသာစကား' : 'Language',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      langProvider.isMyanmar ? 'မြန်မာ' : 'English',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  onTap: () => langProvider.toggleLanguage(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // PREFERENCES SECTION
          _buildSectionHeader(
            langProvider.isMyanmar ? 'အသိပေးချက်များ' : 'PREFERENCES',
            subtitleColor,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: subtitleColor.withOpacity(0.15)),
            ),
            child: SwitchListTile(
              activeColor: primaryColor,
              secondary: Icon(Icons.notifications_none_rounded, color: primaryColor),
              title: Text(
                langProvider.isMyanmar ? 'အသိပေးချက်များ ရယူရန်' : 'Push Notifications',
                style: TextStyle(color: primaryColor, fontSize: 14),
              ),
              value: true,
              onChanged: (val) {},
            ),
          ),
          const SizedBox(height: 24),

          // ABOUT SECTION
          _buildSectionHeader(
            langProvider.isMyanmar ? 'အခြားအချက်အလက်များ' : 'ABOUT',
            subtitleColor,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: subtitleColor.withOpacity(0.15)),
            ),
            child: ListTile(
              leading: Icon(Icons.info_outline_rounded, color: primaryColor),
              title: Text(
                langProvider.isMyanmar ? 'အက်ပ် ဗားရှင်း' : 'App Version',
                style: TextStyle(color: primaryColor, fontSize: 14),
              ),
              trailing: Text(
                'v1.0.0',
                style: TextStyle(
                  color: subtitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }
}