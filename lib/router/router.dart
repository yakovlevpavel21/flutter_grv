import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/auth/ui/login_screen.dart';
import 'package:grv/features/products/data/models/product.dart';
import 'package:grv/features/products/ui/product_detail_screen.dart';
import 'package:grv/features/products/ui/product_form_screen.dart';
import 'package:grv/features/products/ui/products_screen.dart';
import 'package:grv/router/shell.dart';
import 'package:grv/router/wrapper.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppWrapper(),
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
                  builder: (_, __) => const ProductsScreen(),
                ),
              ],
            ),

            // 🕘 История
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'history',
                  builder: (_, __) => const ProductsScreen(),
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
                    final product = state.extra as ProductModel;
                    return ProductDetailScreen(product: product);
                  },
                ),
              ],
            ),

            // 🧱 Материалы
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'materials',
                  builder: (_, __) => const ProductsScreen(),
                ),
              ],
            ),

            // ⚙️ Настройки
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (_, __) => const ProductsScreen(),
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
    );
  }
}