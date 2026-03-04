import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/data/repositories/category_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/category/category_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class CategoryFormSheet extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  final CategoryEntity? category;
  const CategoryFormSheet({super.key, required this.categoriesBloc, this.category});

  @override
  State<CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends State<CategoryFormSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => CategoryBloc(
          repository: CategoryEditRepositoryImpl(),
        ),
        child: BlocListener<CategoryBloc, CategoryInitial>(
          listenWhen: (p, c) => c.status == CategoryStatus.success,
          listener: (context, state) {
            Navigator.pop(context);
            widget.categoriesBloc.add(LoadCategories());
          },
          child: _CategoryFormBody(),
        ),
      ),
    );
  }
}

class _CategoryFormBody extends StatefulWidget {
  const _CategoryFormBody();

  @override
  State<_CategoryFormBody> createState() => __CategoryFormBodyState();
}

class __CategoryFormBodyState extends State<_CategoryFormBody> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final name = context.read<CategoryBloc>().state.name;
    _nameController = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryInitial>(
      builder: (context, state) {
        return BaseFormSheet(
          title: state.isEditing ? 'Редактирование' : 'Добавление', 
          isLoading: state.status == CategoryStatus.loading,
          canSubmit: state.canSubmit,
          onSave: () => context.read<CategoryBloc>().add(CategorySubmitted()),
          child: TextField(
            controller: _nameController,
            onChanged: (v) => context.read<CategoryBloc>().add(NameChanged(name: v)),
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Название'),
          ),
        );
      }
    );
  }
}