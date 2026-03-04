import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/auth/ui/login_screen.dart';
import 'package:grv/features/home/presentation/screens/home_screen.dart';
import 'package:grv/features/categories/presentation/screens/variants_screen.dart';
import 'package:grv/features/categories/presentation/screens/products_screen.dart';
import 'package:grv/features/materials/presentation/screens/colors_screen.dart';
import 'package:grv/features/settings/ui/settings_screen.dart';
import 'package:grv/features/shipments/presentation/screens/shipment_form_screen.dart';
import 'package:grv/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:grv/features/materials/presentation/screens/materials_screen.dart';
import 'package:grv/features/categories/presentation/screens/categories_screen.dart';
import 'package:grv/features/categories/presentation/screens/stocks_screen.dart';
import 'package:grv/router/shell.dart';

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
              builder: (_, __) => const CategoriesScreen(),
              routes: [
                GoRoute(
                  path: 'categories/:categoryId',
                  builder: (context, state) {
                    final id = int.parse(state.pathParameters['categoryId']!);
                    return ProductsScreen(categoryId: id);
                  },
                  routes: [
                    GoRoute(
                      path: 'products/:productId',
                      builder: (context, state) {
                        final catId = int.parse(state.pathParameters['categoryId']!);
                        final prodId = int.parse(state.pathParameters['productId']!);
                        return VariantsScreen(categoryId: catId, productId: prodId);
                      },
                      routes: [
                        GoRoute(
                          path: 'variants/:variantId',
                          builder: (context, state) {
                            final catId = int.parse(state.pathParameters['categoryId']!);
                            final prodId = int.parse(state.pathParameters['productId']!);
                            final varId = int.parse(state.pathParameters['variantId']!);
                            return StocksScreen( 
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

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/materials',
              builder: (_, __) => const MaterialsScreen(),
              routes: [
                GoRoute(
                  path: 'colors', 
                  builder: (_, __) => const ColorsScreen(),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (_, __) => const SettingsScreen(),
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
      scrollBehavior: MyCustomScrollBehavior(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  };
}