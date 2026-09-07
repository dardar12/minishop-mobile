import 'package:flutter/material.dart';
import 'package:mini_shop/view/get_started_view.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Mini Shop App',
            debugShowCheckedModeBanner: false,
            
            //  Light Theme Setup
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepOrange,
                brightness: Brightness.light,
              ),
              scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            ),

            //  Dark Theme Setup
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepOrange,
                brightness: Brightness.dark,
              ),
              scaffoldBackgroundColor: const Color(0xFF121212),
            ),

            // Theme Mode switcher
            themeMode: themeProvider.themeMode,
 home: const GetStartedView(),
          );
        },
      ),
    );
  }
}