import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/category/data/models/product_item.dart';
import 'package:grv/features/colors/logic/colors_bloc.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/widgets/semi_stock_form_sheet.dart';
import 'package:grv/features/product/widgets/semi_stocks_list.dart';
import 'package:grv/features/product/widgets/variants_grid.dart';
import 'package:grv/features/product/widgets/variant_form_sheet.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class ProductScreen extends StatelessWidget {
  final int categoryId;
  final int productId;

  const ProductScreen({super.key, required this.categoryId, required this.productId});

  void _showAddVariantSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VariantFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
        productId: productId,
      ),
    );
  }

  void _showAddSemiStockSheet(BuildContext context, ProductItemUi product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SemiStockFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
        productId: productId,
        usedColorIds: product.semiStocksList.map((i) => i.color.id).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NomenclatureBloc, NomenclatureState>(
      builder: (context, state) {
        if (state is NomenclatureLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is NomenclatureError) {
          return Scaffold(
            body: ErrorCard(
              title: 'Ошибка',
              description: state.message,
              onReload: () => context.read<NomenclatureBloc>().add(LoadNomenclature()),
            ),
          );
        }

        if (state is NomenclatureLoaded) {
          final product = state.nomenclature.categories[categoryId]?.products[productId];

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

  Widget _buildBody(ProductItemUi product, BuildContext context) {
    if (product.variants.isEmpty) {
      return const EmptyState();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Варианты', style: TextStyle(fontWeight: FontWeight.w700)),
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
                    Text('Количество полуфабрикатов', style: TextStyle(fontWeight: FontWeight.w700),),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _showAddSemiStockSheet(context, product),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),

                Expanded(
                  child: SemiStocksList(
                    categoryId: categoryId, 
                    productId: productId, 
                    semiStocks: product.semiStocksList
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}