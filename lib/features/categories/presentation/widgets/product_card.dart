import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/data/repositories/product_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/product/product_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/product_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';

class ProductCard extends StatelessWidget {
  final int categoryId;
  final ProductEntity product;
  const ProductCard({super.key, required this.categoryId, required this.product});

  void _onEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
        categoryId: categoryId,
        product: product,
      ),
    );
  }

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => DialogCard(
        type: DialogType.warning,
        message: 'Ты уверен?\nВсе инвентари этого товара будут удалены!',
        button: BlocProvider(
          create: (_) => ProductBloc(
            repository:  ProductEditRepositoryImpl(),
            categoryId: categoryId
          ),
          child: _DeleteButton(
            categoryId: product.id, 
            onSuccess: () {
              Navigator.pop(dialogCtx);
              context.read<CategoriesBloc>().add(LoadCategories());
            }
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.push('/nomenclature/categories/$categoryId/products/${product.id}');
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') _onEdit(context);
                  if (value == 'delete') _onDelete(context);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(value: 'edit', child: Text('Изменить')),
                  const PopupMenuItem<String>(value: 'delete', child: Text('Удалить')),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int categoryId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.categoryId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductInitial>(
      listener: (context, state) {
        if (state.status == ProductStatus.success) onSuccess();
        if (state.status == ProductStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == ProductStatus.loading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<ProductBloc>().add(DeleteProduct(id: categoryId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}