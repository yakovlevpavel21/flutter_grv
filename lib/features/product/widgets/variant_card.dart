import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/data/models/variant_item.dart';
import 'package:grv/features/product/data/repos/variant_repo.dart';
import 'package:grv/features/product/logic/variant_bloc.dart';
import 'package:grv/features/product/widgets/variant_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';

class VariantCard extends StatelessWidget {
  final int categoryId;
  final int productId;
  final VariantItemUi variant;
  const VariantCard({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.variant
  });

  void _onEdit(BuildContext context) {
    context.read<NomenclatureBloc>().add(VariantSelected(id: variant.id));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VariantFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
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
        message: 'Ты уверен?\nВсе продукции этого инвенторя будут удалены!',
        button: BlocProvider(
          create: (_) => VariantBloc(VariantRepository()),
          child: _DeleteButton(
            variantId: variant.id, 
            onSuccess: () {
              Navigator.pop(dialogCtx);
              context.read<NomenclatureBloc>().add(LoadNomenclature());
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
          context.read<NomenclatureBloc>().add(CategorySelected(id: variant.id));
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
  final int variantId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.variantId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VariantBloc, VariantState>(
      listener: (context, state) {
        if (state is VariantSuccess) onSuccess();
        if (state is VariantError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is VariantLoading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<VariantBloc>().add(DeleteVariant(id: variantId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}