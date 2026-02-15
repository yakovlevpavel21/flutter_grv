import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/auth/ui/login_screen.dart';
import 'package:grv/features/home/ui/home_screen.dart';
import 'package:grv/features/nomenclature/data/models/category_item.dart';
import 'package:grv/features/category/data/models/product_item.dart';
import 'package:grv/features/product/ui/product_screen.dart';
import 'package:grv/features/category/ui/category_screen.dart';
import 'package:grv/features/nomenclature/widgets/categories_grid.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/ui/shipment_form_screen.dart';
import 'package:grv/features/shipments/ui/shipments_screen.dart';
import 'package:grv/features/materials/ui/materials_screen.dart';
import 'package:grv/features/nomenclature/ui/nomenclature_screen.dart';
import 'package:grv/features/settings/ui/settings_screen.dart';
import 'package:grv/features/variant/ui/variant.dart';
import 'package:grv/router/shell.dart';
import 'package:grv/router/wrapper.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home', 
              builder: (_, __) => const HomeScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shipments',
              builder: (_, __) => const ShipmentsScreen(),
              routes: [
                GoRoute(
                  path: 'new', 
                  builder: (_, __) => const ShipmentFormScreen(),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/nomenclature',
              builder: (_, __) => const NomenclatureScreen(),
              routes: [
                GoRoute(
                  path: 'categories/:categoryId',
                  builder: (context, state) {
                    final id = int.parse(state.pathParameters['categoryId']!);
                    return CategoryScreen(categoryId: id);
                  },
                  routes: [
                    GoRoute(
                      path: 'products/:productId',
                      builder: (context, state) {
                        final catId = int.parse(state.pathParameters['categoryId']!);
                        final prodId = int.parse(state.pathParameters['productId']!);
                        return ProductScreen(categoryId: catId, productId: prodId);
                      },
                      routes: [
                        GoRoute(
                          path: 'variants/:variantId',
                          builder: (context, state) {
                            final catId = int.parse(state.pathParameters['categoryId']!);
                            final prodId = int.parse(state.pathParameters['productId']!);
                            final varId = int.parse(state.pathParameters['variantId']!);
                            return VariantScreen( 
                              categoryId: catId, 
                              productId: prodId, 
                              variantId: varId
                            );
                          },
                        ),
                      ],
                    ),
                  ],
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