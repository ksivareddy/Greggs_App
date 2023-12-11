import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'cart_details.dart';
import 'provider/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Greggs App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
                routes: {
          '/': (context) => const Home(),
          '/cart': (context) => const CartDetails(),
        },
      ),
    );
  }
}