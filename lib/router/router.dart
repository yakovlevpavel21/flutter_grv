import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/products/data/models/product.dart';
import 'package:grv/features/products/ui/product_detail_screen.dart';
import 'package:grv/features/products/ui/product_form_screen.dart';
import 'package:grv/features/products/ui/products_screen.dart';
import 'package:grv/router/wrapper.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppWrapper(),
      routes: [
        GoRoute(
          path: 'products',
          builder: (context, state) => const ProductsScreen(),
        ),
        GoRoute(
          path: 'product/new',
          builder: (context, state) {
            return ProductFormScreen();
          },
        ),
        GoRoute(
          path: 'product/:id',
          builder: (context, state) {
            final product = state.extra as ProductModel;
            return ProductDetailScreen(product: product);
          },
        ),
        GoRoute(
          path: 'product/:id/edit',
          builder: (context, state) {
            final product = state.extra as ProductModel?;
            return ProductFormScreen(product: product);
          },
        ),
      ],
    ),
  ],
);

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}