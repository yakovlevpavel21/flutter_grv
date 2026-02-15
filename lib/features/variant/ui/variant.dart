import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/category/data/models/product_item.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/data/models/variant_item.dart';
import 'package:grv/features/product/widgets/variants_grid.dart';
import 'package:grv/features/product/widgets/variant_form_sheet.dart';
import 'package:grv/features/variant/widgets/stock_form_sheet.dart';
import 'package:grv/features/variant/widgets/stocks_grid.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class VariantScreen extends StatelessWidget {
  final int categoryId;
  final int productId;
  final int variantId;

  const VariantScreen({
    super.key, 
    required this.categoryId, 
    required this.productId,
    required this.variantId,
  });

  void _showAddVariantSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => StockFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
        variantId: variantId,
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
          final variant = state.nomenclature
            .categories[categoryId]
            ?.products[productId]
            ?.variants[variantId];

          if (variant == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Товар не найден')),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(variant.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddVariantSheet(context),
                ),
              ],
            ),
            body: _buildBody(variant),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBody(VariantItemUi variant) {
    if (variant.stocks.isEmpty) {
      return const EmptyState();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: StocksGrid(
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