import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/data/repositories/category_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/category/category_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/category_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  const CategoryCard({super.key, required this.category});

  void _onEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CategoryFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
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
          create: (_) => CategoryBloc(
            repository: CategoryEditRepositoryImpl()
          ),
          child: _DeleteButton(
            categoryId: category.id, 
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
          context.push('/nomenclature/categories/${category.id}');
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
    return BlocConsumer<CategoryBloc, CategoryInitial>(
      listener: (context, state) {
        if (state.status == CategoryStatus.success) onSuccess();
        if (state.status == CategoryStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == CategoryStatus.loading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<CategoryBloc>().add(DeleteCategory(id: categoryId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}