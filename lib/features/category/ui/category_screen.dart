import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/nomenclature/data/models/category_item.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/category/widgets/product_form_sheet.dart';
import 'package:grv/features/category/widgets/products_grid.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class CategoryScreen extends StatelessWidget {
  final int categoryId;

  const CategoryScreen({super.key, required this.categoryId});

  void _showAddProductSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
        categoryId: categoryId,
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
          final category = state.nomenclature.categories[categoryId];

          if (category == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Категория не найдена')),
            );
          }

          return Scaffold(
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
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBody(CategoryItemUi category) {
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