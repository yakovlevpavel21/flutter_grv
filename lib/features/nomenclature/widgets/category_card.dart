import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/nomenclature/data/models/category_item.dart';
import 'package:grv/features/nomenclature/data/repos/category_repo.dart';
import 'package:grv/features/nomenclature/logic/category_bloc.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/nomenclature/widgets/category_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItemUi category;
  const CategoryCard({super.key, required this.category});

  void _onEdit(BuildContext context) {
    context.read<NomenclatureBloc>().add(CategorySelected(id: category.id));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CategoryFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
        category: category,
      ),
    );
  }

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => DialogCard(
        type: DialogType.warning,
        message: 'Ты уверен?\nВсе товары этой категории будут удалены!',
        button: BlocProvider(
          create: (_) => CategoryBloc(CategoryRepository()),
          child: _DeleteButton(
            categoryId: category.id, 
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
          context.push('/nomenclature/categories/${category.id}');
          context.read<NomenclatureBloc>().add(CategorySelected(id: category.id));
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                category.name,
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
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategorySuccess) onSuccess();
        if (state is CategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<CategoryBloc>().add(DeleteCategory(id: categoryId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}