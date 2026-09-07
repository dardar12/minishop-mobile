import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isMyanmar => _locale.languageCode == 'my';

  void toggleLanguage() {
    _locale = _locale.languageCode == 'en' ? const Locale('my') : const Locale('en');
    notifyListeners();
  }

  List<Map<String, String>> get onboardingPages => [
        {
          'title': isMyanmar ? 'အွန်လိုင်းစတိုး ရွေးချယ်ပါ' : 'Choose an online store',
          'subtitle': isMyanmar ? 'စတိုး' : 'STORE',
          'description': isMyanmar 
              ? 'စိတ်ကြိုက် ပစ္စည်းများကို တစ်နေရာတည်းတွင် လွယ်ကူစွာ ကြည့်ရှုဝယ်ယူနိုင်ပါသည်။' 
              : 'Browse high-quality products, electronics, and fashion directly from top stores.',
        },
        {
          'title': isMyanmar ? 'ပစ္စည်းများကို ရှာဖွေပါ' : 'Find your products',
          'subtitle': isMyanmar ? 'ရှာဖွေမှု' : 'PRODUCTS',
          'description': isMyanmar 
              ? 'အဝတ်အထည်နှင့် စက်ပစ္စည်းများစွာကို အမျိုးအစားအလိုက် လျင်မြန်စွာ ရှာဖွေပါ။' 
              : 'Filter through thousands of items with smart search and instant categories.',
        },
        {
          'title': isMyanmar ? 'မှာယူမှုကို လက်ခံပါ' : 'Get your order!',
          'subtitle': isMyanmar ? 'ပို့ဆောင်မှု' : 'DELIVERY',
          'description': isMyanmar 
              ? 'မြန်ဆန် စိတ်ချရသော အရောက်ပို့ ဝန်ဆောင်မှုဖြင့် သင့်ထံသို့ ပေးပို့ပေးပါမည်။' 
              : 'Fast, secure, and seamless checkout experience right to your doorstep.',
        },
      ];

  String get next => isMyanmar ? 'ရှေ့သို့' : 'Next';
  String get getStarted => isMyanmar ? 'စတင်အသုံးပြုမည်' : 'Get started';
}