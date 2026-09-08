import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_shop/providers/favourite_provider.dart';
import 'package:mini_shop/view/settings_view.dart';
import 'package:mini_shop/view/shipping_address_view.dart';

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
  bool _showOnlyFavorites = false;
  int _activeBannerIndex = 0;

  final PageController _bannerController = PageController(initialPage: 0);
  final TextEditingController _searchController = TextEditingController();
  Timer? _bannerTimer;
  String _searchQuery = '';

  // Promo Banner Data
  final List<Map<String, String>> _bannerData = [
    {
      'tag': 'NEW ARRIVALS',
      'title': 'Glow Naturally,\nShine Beautifully',
      'subtitle': 'Explore our premium beauty collection for radiant you.',
      'image':
          'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800&q=80',
    },
    {
      'tag': 'SPECIAL OFFER',
      'title': '30% OFF On\nSkincare Essentials',
      'subtitle': 'Hydrate and restore your natural glow today.',
      'image':
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=800&q=80',
    },
    {
      'tag': 'LIMITED EDITION',
      'title': 'Discover Your\nSignature Fragrance',
      'subtitle': 'Luxury perfumes tailored specifically for you.',
      'image':
          'https://images.unsplash.com/photo-1541643600914-78b084683601?w=800&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startBannerTimer();

    Future.microtask(
      () => Provider.of<ProductProvider>(context, listen: false).loadProducts(),
    );
  }

  void _startBannerTimer() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients && mounted) {
        int nextPageIndex = (_activeBannerIndex + 1) % _bannerData.length;
        _bannerController.animateToPage(
          nextPageIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

void _showProfileBottomSheet(
    BuildContext context,
    Color bgColor,
    Color primaryColor,
    Color subtitleColor,
    Color accentColor,
  ) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: subtitleColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&q=80',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Dar Dar',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'dardar@example.com',
                style: TextStyle(color: subtitleColor, fontSize: 13),
              ),
              const SizedBox(height: 24),
              
            // 1. MY ORDERS -> CartView
              ListTile(
                leading: Icon(Icons.shopping_bag_outlined, color: primaryColor),
                title: Text(
                  langProvider.isMyanmar ? 'ကျွန်ုပ်၏ မှာယူမှုများ' : 'My Orders',
                  style: TextStyle(color: primaryColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartView()),
                  );
                },
              ),

              // 2. SAVED ITEMS -> Favorites Toggle
              ListTile(
                leading: Icon(Icons.favorite_border_rounded, color: primaryColor),
                title: Text(
                  langProvider.isMyanmar ? 'သိမ်းဆည်းထားသော အရာများ' : 'Saved Items',
                  style: TextStyle(color: primaryColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                },
              ),

              // 3. SHIPPING ADDRESS -> ShippingAddressView
              ListTile(
                leading: Icon(Icons.location_on_outlined, color: primaryColor),
                title: Text(
                  langProvider.isMyanmar ? 'ပို့ဆောင်ရမည့် လိပ်စာ' : 'Shipping Address',
                  style: TextStyle(color: primaryColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShippingAddressView()),
                  );
                },
              ),

              // 4. SETTINGS -> SettingsView
              ListTile(
                leading: Icon(Icons.settings_outlined, color: primaryColor),
                title: Text(
                  langProvider.isMyanmar ? 'ပြင်ဆင်ချက်များ' : 'Settings',
                  style: TextStyle(color: primaryColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsView()),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final horizontalPadding = screenWidth > 600 ? 32.0 : 18.0;
    final bannerHeight = screenWidth > 600 ? 220.0 : 185.0;

    final bgColor = isDark ? const Color(0xFF101010) : const Color(0xFFFAF7F5);
    final primaryColor = isDark ? Colors.white : const Color(0xFF2C221E);
    final secondaryColor = isDark ? Colors.black : Colors.white;
    final cardBgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final subtitleColor = isDark
        ? Colors.grey.shade400
        : const Color(0xFF8C827A);
    const accentColor = Color(0xFFE88B6E);

    final baseProducts = _showOnlyFavorites
        ? favoriteProvider.favoriteProducts
        : productProvider.products;

    final displayedProducts = baseProducts.where((product) {
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: productProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: accentColor,
                  strokeWidth: 2,
                ),
              )
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1. PROFILE & HEADER SECTION
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        16,
                        horizontalPadding,
                        12,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _showProfileBottomSheet(
                              context,
                              bgColor,
                              primaryColor,
                              subtitleColor,
                              accentColor,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: accentColor,
                                  width: 1.5,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&q=80',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: subtitleColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: langProvider.isMyanmar
                                                ? 'မင်္ဂလာပါ '
                                                : 'Hello, ',
                                          ),
                                          TextSpan(
                                            text: 'Dar Dar!',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Consumer<FavoriteProvider>(
                            builder: (context, fav, child) => Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _buildHeaderIconButton(
                                  icon: _showOnlyFavorites
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  iconColor: _showOnlyFavorites
                                      ? accentColor
                                      : primaryColor,
                                  cardBgColor: cardBgColor,
                                  onTap: () {
                                    setState(() {
                                      _showOnlyFavorites = !_showOnlyFavorites;
                                    });
                                  },
                                ),
                                if (fav.favoriteProducts.isNotEmpty)
                                  Positioned(
                                    top: -2,
                                    right: -2,
                                    child: _buildBadge(
                                      count: fav.favoriteProducts.length,
                                      badgeColor: accentColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          _buildHeaderIconButton(
                            icon: isDark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            iconColor: primaryColor,
                            cardBgColor: cardBgColor,
                            onTap: () => themeProvider.toggleTheme(!isDark),
                          ),
                          const SizedBox(width: 10),
                          Consumer<CartProvider>(
                            builder: (context, cart, child) => Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _buildHeaderIconButton(
                                  icon: Icons.shopping_bag_outlined,
                                  iconColor: primaryColor,
                                  cardBgColor: cardBgColor,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartView(),
                                      ),
                                    );
                                  },
                                ),
                                if (cart.itemCount > 0)
                                  Positioned(
                                    top: -2,
                                    right: -2,
                                    child: _buildBadge(
                                      count: cart.itemCount,
                                      badgeColor: primaryColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 2. ADS / PROMO BANNER SECTION
                  if (!_showOnlyFavorites) ...[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            height: bannerHeight,
                            child: PageView.builder(
                              controller: _bannerController,
                              itemCount: _bannerData.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _activeBannerIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final banner = _bannerData[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? Colors.black26
                                            : accentColor.withOpacity(0.08),
                                        blurRadius: 16,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: isDark
                                          ? [
                                              const Color(0xFF2D2320),
                                              const Color(0xFF1E1715),
                                            ]
                                          : [
                                              const Color(0xFFFFF0EB),
                                              const Color(0xFFFDE4DC),
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: accentColor
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    banner['tag']!,
                                                    style: const TextStyle(
                                                      color: accentColor,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  banner['title']!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.1,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  banner['subtitle']!,
                                                  style: TextStyle(
                                                    color: subtitleColor,
                                                    fontSize: 10,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 8),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        accentColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    elevation: 0,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 6,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Text(
                                                        'Shop Now',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(width: 4),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_rounded,
                                                        size: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            flex: 2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                banner['image']!,
                                                fit: BoxFit.cover,
                                                height: double.infinity,
                                                errorBuilder:
                                                    (context, error, stack) =>
                                                        const Icon(
                                                          Icons.image_rounded,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _bannerData.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                height: 6,
                                width: _activeBannerIndex == index ? 20 : 6,
                                decoration: BoxDecoration(
                                  color: _activeBannerIndex == index
                                      ? accentColor
                                      : subtitleColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 3. SEARCH BAR (FUNCTIONAL)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          18,
                          horizontalPadding,
                          14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: cardBgColor,
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: subtitleColor.withOpacity(0.12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery = value;
                                    });
                                  },
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: langProvider.isMyanmar
                                        ? 'ပစ္စည်းများ ရှာဖွေပါ...'
                                        : 'Search for products...',
                                    hintStyle: TextStyle(
                                      color: subtitleColor,
                                      fontSize: 13,
                                    ),
                                    icon: Icon(
                                      Icons.search_rounded,
                                      color: subtitleColor,
                                      size: 20,
                                    ),
                                    suffixIcon: _searchQuery.isNotEmpty
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.clear,
                                              color: subtitleColor,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              _searchController.clear();
                                              setState(() {
                                                _searchQuery = '';
                                              });
                                            },
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: cardBgColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: subtitleColor.withOpacity(0.12),
                                ),
                              ),
                              child: Icon(
                                Icons.tune_rounded,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 42,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          itemCount: productProvider.categories.length,
                          itemBuilder: (context, index) {
                            final category = productProvider.categories[index];
                            final isSelected =
                                category == productProvider.selectedCategory;

                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () =>
                                    productProvider.selectCategory(category),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? primaryColor
                                        : cardBgColor,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: isSelected
                                          ? primaryColor
                                          : subtitleColor.withOpacity(0.15),
                                    ),
                                  ),
                                  child: Text(
                                    category.toUpperCase(),
                                    style: TextStyle(
                                      color: isSelected
                                          ? secondaryColor
                                          : primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ] else ...[
                    // Favorites Section Header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          16,
                          horizontalPadding,
                          12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              langProvider.isMyanmar
                                  ? 'စိတ်ကြိုက်ပစ္စည်းများ'
                                  : 'FAVORITES',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  setState(() => _showOnlyFavorites = false),
                              child: Text(
                                langProvider.isMyanmar
                                    ? 'အားလုံးကြည့်ရန်'
                                    : 'Show All',
                                style: const TextStyle(
                                  color: accentColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // 5. SECTION TITLE
                  if (!_showOnlyFavorites)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          22,
                          horizontalPadding,
                          12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              langProvider.isMyanmar
                                  ? 'လူကြိုက်အများဆုံး'
                                  : 'Best Sellers',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  langProvider.isMyanmar
                                      ? 'အားလုံး'
                                      : 'View All',
                                  style: TextStyle(
                                    color: subtitleColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: subtitleColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  // 6. RESPONSIVE PRODUCT GRID
                  if (displayedProducts.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _showOnlyFavorites
                                  ? Icons.favorite_border_rounded
                                  : Icons.search_off_rounded,
                              size: 56,
                              color: subtitleColor.withOpacity(0.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _showOnlyFavorites
                                  ? (langProvider.isMyanmar
                                        ? 'စိတ်ကြိုက်ပစ္စည်းများ မရှိသေးပါ'
                                        : 'No favorites added yet')
                                  : (langProvider.isMyanmar
                                        ? 'ရှာဖွေမှု ပစ္စည်းမရှိပါ'
                                        : 'No products found'),
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        8,
                        horizontalPadding,
                        24,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 220,
                              childAspectRatio: 0.64,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = displayedProducts[index];
                          final isFav = favoriteProvider.isFavorite(product.id);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailView(product: product),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardBgColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: subtitleColor.withOpacity(0.08),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.black26
                                                  : const Color(0xFFF9F9F9),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Image.network(
                                                product.image,
                                                fit: BoxFit.contain,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      color: subtitleColor,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 6,
                                            right: 6,
                                            child: InkWell(
                                              onTap: () {
                                                favoriteProvider.toggleFavorite(
                                                  product,
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: cardBgColor,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.06),
                                                      blurRadius: 6,
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  isFav
                                                      ? Icons.favorite_rounded
                                                      : Icons
                                                            .favorite_border_rounded,
                                                  color: isFav
                                                      ? accentColor
                                                      : subtitleColor,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Consumer<CartProvider>(
                                          builder: (context, cart, _) =>
                                              InkWell(
                                                onTap: () {
                                                  cart.addToCart(product);
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.add_rounded,
                                                    color: secondaryColor,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }, childCount: displayedProducts.length),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeaderIconButton({
    required IconData icon,
    required Color iconColor,
    required Color cardBgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.12)),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildBadge({required int count, required Color badgeColor}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      child: Text(
        '$count',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
