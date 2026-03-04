import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/data/repositories/product_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/product/product_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class ProductFormSheet extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  final ProductEntity? product;
  final int categoryId;
  const ProductFormSheet({super.key, required this.categoriesBloc, this.product, required this.categoryId});

  @override
  State<ProductFormSheet> createState() => _ProductFormSheetState();
}

class _ProductFormSheetState extends State<ProductFormSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => ProductBloc(
          repository: ProductEditRepositoryImpl(),
          categoryId: widget.categoryId,
          productEntity: widget.product
        ),
        child: BlocListener<ProductBloc, ProductInitial>(
          listenWhen: (p, c) => c.status == ProductStatus.success,
          listener: (context, state) {
            Navigator.pop(context);
            widget.categoriesBloc.add(LoadCategories());
          },
          child: _ProductFormBody(),
        ),
      ),
    );
  }
}

class _ProductFormBody extends StatefulWidget {
  const _ProductFormBody();

  @override
  State<_ProductFormBody> createState() => __ProductFormBodyState();
}

class __ProductFormBodyState extends State<_ProductFormBody> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final name = context.read<ProductBloc>().state.name;
    _nameController = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductInitial>(
      builder: (context, state) {
        return BaseFormSheet(
          title: state.isEditing ? 'Редактирование' : 'Добавление', 
          isLoading: state.status == ProductStatus.loading,
          canSubmit: state.canSubmit,
          onSave: () => context.read<ProductBloc>().add(ProductSubmitted()),
          child: TextField(
            controller: _nameController,
            onChanged: (v) => context.read<ProductBloc>().add(NameChanged(name: v)),
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Название'),
          ),
        );
      }
    );
  }
}