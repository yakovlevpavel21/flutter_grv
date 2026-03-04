import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/data/repositories/variant_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/variant/variant_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/variant_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';
import 'package:grv/widgets/edit_delete_menu_button.dart';

class VariantCard extends StatelessWidget {
  final int categoryId;
  final int productId;
  final VariantEntity variant;
  const VariantCard({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.variant
  });

  void _onEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VariantFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
        productId: productId,
        variant: variant,
      ),
    );
  }

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => DialogCard(
        type: DialogType.warning,
        message: 'Надеюсь ты знаешь что делаешь!',
        button: BlocProvider(
          create: (_) => VariantBloc(
            repository: VariantEditRepositoryImpl(),
            variantEntity: variant,
            productId: productId,
          ),
          child: _DeleteButton(
            variantId: variant.id, 
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
          context.push('/nomenclature/categories/$categoryId/products/$productId/variants/${variant.id}');
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                variant.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: EditDeleteMenuButton(
                onEdit: () => _onEdit(context), 
                onDelete: () => _onDelete(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int variantId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.variantId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VariantBloc, VariantInitial>(
      listener: (context, state) {
        if (state.status == VariantStatus.success) onSuccess();
        if (state.status == VariantStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == VariantStatus.loading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<VariantBloc>().add(VariantDeleted(id: variantId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}