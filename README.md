# 🛒 MiniShop — Flutter E-Commerce App

A minimalist Flutter e-commerce app featuring Dark/Light modes, multi-language support (English & Myanmar), product favorites, shipping address management, settings, checkout integration, and Provider state management.

---

## ✨ Features

- **🖤 Warm Minimalist UI:** Elegant aesthetic with clean visual hierarchy and smooth responsive layouts.
- **🌗 Dark & Light Themes:** Instant switching between Dark and Light modes across all views.
- **🌐 Multi-Language Support:** Full translation support between English and Myanmar (Burmese).
- **👤 User Profile & Navigation:** Profile drawer/bottom sheet access to orders, saved items, addresses, and settings.
- **❤️ Favorites Management:** Toggle products as favorites, view live badges, and filter saved items directly on the catalog.
- **🛍️ Cart & Checkout Flow:** Real-time cart badge counters, quantity adjustments, order summaries, and custom checkout dialog feedback.
- **📍 Shipping Address Management:** Interactive address selection and delivery location updates.
- **⚙️ Settings & Preferences:** Dynamic theme toggling, language selection, push notifications, and app metadata display.
- **📦 Dynamic Product Catalog:** Auto-sliding promo banners, real-time product search, category filtering, and detailed product views.

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **State Management:** Provider
- **Language:** Dart

---

## 📁 Project Structure

```text
lib/
├── models/
│   ├── product.dart
│   └── cart_item.dart
├── providers/
│   ├── product_provider.dart
│   ├── cart_provider.dart
│   ├── favorite_provider.dart
│   ├── theme_provider.dart
│   └── language_provider.dart
└── view/
    ├── get_started_view.dart
    ├── product_list_view.dart
    ├── product_detail_view.dart
    ├── cart_view.dart
    ├── check_out_view.dart
    ├── settings_view.dart
    └── shipping_address_view.dart
