import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/stocks_list.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class StocksScreen extends StatelessWidget {
  final int categoryId;
  final int productId;
  final int variantId;

  const StocksScreen({
    super.key, 
    required this.categoryId, 
    required this.productId,
    required this.variantId,
  });

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
          final variant = state
            .categories[categoryId]
            ?.products[productId]
            ?.variants[variantId];

          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer<void>();
              context.read<CategoriesBloc>().add(LoadCategories(completer: completer));
              return completer.future;
            },
            child: variant == null 
                ? Scaffold(
                    appBar: AppBar(),
                    body: const Center(child: Text('Товар не найден')),
                  )
                : Scaffold(
                  appBar: AppBar(
                    title: Text(variant.name),
                    actions: [],
                  ),
                  body: _buildBody(variant),
                ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBody(VariantEntity variant) {
    if (variant.stocks.isEmpty) {
      return const EmptyState();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: StocksList(
              categoryId: categoryId,
              productId: variant.id,
              stocks: variant.stocksList
            ),
          ),
        ),
      ),
    );
  }
}