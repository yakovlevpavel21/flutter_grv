import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/uncollected_stock_form_sheet.dart';
import 'package:grv/features/categories/presentation/widgets/uncollected_stocks_list.dart';
import 'package:grv/features/categories/presentation/widgets/variants_grid.dart';
import 'package:grv/features/categories/presentation/widgets/variant_form_sheet.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';
import 'package:grv/widgets/error_card.dart';

class VariantsScreen extends StatelessWidget {
  final int categoryId;
  final int productId;

  const VariantsScreen({super.key, required this.categoryId, required this.productId});

  void _showAddVariantSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VariantFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
        productId: productId,
      ),
    );
  }

  void _showAddStockUncollectedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => UncollectedStockFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
        colorsBloc: context.read<ColorsBloc>(),
        productId: productId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ColorsBloc>().add(LoadColors());
    
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
          final product = state.categories[categoryId]?.products[productId];

          if (product == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Товар не найден')),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(product.name),
            ),
            body: _buildBody(product, context),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBody(ProductEntity product, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Вариации', style: TextStyle(fontWeight: FontWeight.w700)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _showAddVariantSheet(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),

                VariantsGrid(
                  categoryId: categoryId,
                  productId: product.id,
                  variants: product.variantsList
                ),
                const SizedBox(height: 12,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Несобранные изделия', style: TextStyle(fontWeight: FontWeight.w700),),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _showAddStockUncollectedSheet(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),

                UncollectedStocksList(
                  categoryId: categoryId, 
                  productId: productId, 
                  uncollectedStocks: product.stocksList.where((s) => s.state == StockState.raw).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}