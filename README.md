# 🛒 MiniShop — Flutter E-Commerce App

A minimalist Flutter e-commerce app featuring Dark/Light modes, multi-language support (English & Myanmar), product favorites, shipping address management, settings, checkout integration, and Provider state management.

---

## ✨ Features

- **🖤 Minimalist UI:** Clean aesthetic with smooth responsive layouts.
- **🌗 Dark & Light Themes:** Instant theme switching.
- **🌐 Multi-Language:** English & Myanmar support.
- **❤️ Favorites & Cart:** Save items, manage cart, and smooth checkout flow.
- **📦 Catalog:** Category filtering and detailed product views.
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
