import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/auth/ui/login_screen.dart';
import 'package:grv/features/shipments/ui/shipments_screen.dart';
import 'package:grv/features/home/ui/home_screen.dart';
import 'package:grv/features/materials/ui/materials_screen.dart';
import 'package:grv/features/products/data/models/product.dart';
import 'package:grv/features/products/ui/product_detail_screen.dart';
import 'package:grv/features/products/ui/product_form_screen.dart';
import 'package:grv/features/products/ui/products_screen.dart';
import 'package:grv/features/settings/ui/settings_screen.dart';
import 'package:grv/router/shell.dart';
import 'package:grv/router/wrapper.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthWrapper(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (_, __) => const LoginScreen(),
        ),

        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainShell(navigationShell: navigationShell);
          },
          branches: [
            // 🏠 Главная
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'home',
                  builder: (_, __) => const HomeWrapper(),
                ),
              ],
            ),

            // 🕘 История
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'shipments',
                  builder: (_, __) => const ShipmentsScreen(),
                ),
              ],
            ),

            // 📦 Товары
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'products',
                  builder: (_, __) => const ProductsScreen(),
                ),
                GoRoute(
                  path: 'products/new',
                  builder: (_, __) => const ProductFormScreen(),
                ),
                GoRoute(
                  path: 'products/:id',
                  builder: (context, state) {
                    final product = state.extra as Product;
                    return ProductDetailScreen(product: product);
                  },
                ),
                GoRoute(
                  path: 'products/:id/edit',
                  builder: (context, state) {
                    final product = state.extra as Product;
                    return ProductFormScreen(product: product);
                  },
                ),
              ],
            ),

            // 🧱 Материалы
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'materials',
                  builder: (_, __) => const MaterialsScreen(),
                ),
              ],
            ),

            // ⚙️ Настройки
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (_, __) => const SettingsScreen(),
                ),
              ],
            ),
          ],
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
      debugShowCheckedModeBanner: false,
    );
  }
}