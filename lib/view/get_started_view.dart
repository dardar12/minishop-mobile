import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import 'product_list_view.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final isDark = themeProvider.isDarkMode;
final bgColor = isDark ? Colors.black : Colors.white;
    final cardBgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final primaryColor = isDark ? Colors.white : Colors.black;
    final secondaryColor = isDark ? Colors.black : Colors.white;
    final subtitleColor = isDark ? Colors.grey.shade400 : const Color(0xFF555555);

    final pages = langProvider.onboardingPages;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: primaryColor, width: 1.5),
                    ),
                    child: Text(
                      'MINISHOP',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
 Row(
                    children: [
                       InkWell(
                        onTap: () => langProvider.toggleLanguage(),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: primaryColor, width: 1.5),
                          ),
                          child: Text(
                            langProvider.isMyanmar ? 'မြန်မာ' : 'EN',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      InkWell(
                        onTap: () => themeProvider.toggleTheme(!isDark),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor, width: 1.5),
                          ),
                          child: Icon(
                            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                            color: primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: primaryColor, width: 2),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: primaryColor.withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              _buildBlackWhiteIllustration(index, primaryColor),
                            ],
                          ),
                        ),

                        const Spacer(),

                        Text(
                          pages[index]['subtitle']!,
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ),
                        ),
                        const SizedBox(height: 10),
Text(
                          pages[index]['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          pages[index]['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
 Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? primaryColor
                        : primaryColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: _currentPage == pages.length - 1
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: secondaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductListView(),
                            ),
                          );
                        },
                        child: Text(
                          langProvider.getStarted,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          side: BorderSide(color: primaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          langProvider.next,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
Widget _buildBlackWhiteIllustration(int index, Color color) {
    switch (index) {
      case 0:
        return Icon(Icons.storefront_outlined, size: 100, color: color);
      case 1:
        return Icon(Icons.shopping_cart_outlined, size: 100, color: color);
      case 2:
        return Icon(Icons.shopping_bag_outlined, size: 100, color: color);
      default:
        return Icon(Icons.store_outlined, size: 100, color: color);
    }
  }
}