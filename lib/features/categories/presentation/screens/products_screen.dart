import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/product_form_sheet.dart';
import 'package:grv/features/categories/presentation/widgets/products_grid.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class ProductsScreen extends StatelessWidget {
  final int categoryId;

  const ProductsScreen({super.key, required this.categoryId});

  void _showAddProductSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
        categoryId: categoryId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is CategoriesError) {
          return Scaffold(
            body: ErrorCard(
              title: 'Ошибка',
              description: state.message,
              onReload: () => context.read<CategoriesBloc>().add(LoadCategories()),
            ),
          );
        }

        if (state is CategoriesLoaded) {
          final category = state.categories[categoryId];

          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer<void>();
              context.read<CategoriesBloc>().add(LoadCategories(completer: completer));
              return completer.future;
            },
            child: category == null 
                ? Scaffold(
                    appBar: AppBar(),
                    body: const Center(child: Text('Категория не найдена')),
                  )
                : Scaffold(
                  appBar: AppBar(
                    title: Text(category.name),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _showAddProductSheet(context),
                      ),
                    ],
                  ),
                  body: _buildBody(category),
                ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBody(CategoryEntity category) {
    if (category.products.isEmpty) {
      return const EmptyState();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ProductsGrid(
              categoryId: category.id,
              products: category.productsList
            ),
          ),
        ),
      ),
    );
  }
}