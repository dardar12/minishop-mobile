# 🛒 MiniShop — Flutter E-Commerce App

A monochrome Flutter e-commerce app featuring Dark/Light modes, multi-language support (English & Myanmar), product favorites, checkout integration, and Provider state management.

---

## ✨ Features

- **🖤 Monochrome Minimalist UI:** Black & White aesthetic with clean line art.
- **🌗 Dark & Light Themes:** Instant switching between Dark and Light modes.
- **🌐 Multi-Language Support:** Toggle between English and Myanmar (Burmese).
- **❤️ Favorites Management:** Toggle products as favorites, check favorite status, and filter favorite items.
- **🛍️ Cart Management:** Add items, adjust quantities, view total price, and clear cart.
- **💳 Checkout Flow:** Confirm orders, view total amounts, and complete checkout with custom dialog feedback.
- **📦 Dynamic Product Catalog:** Browse products with category filtering and detailed views.

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
└── views/
    ├── get_started_view.dart
    ├── product_list_view.dart
    ├── product_detail_view.dart
    ├── cart_view.dart
    └── check_out_view.dart
