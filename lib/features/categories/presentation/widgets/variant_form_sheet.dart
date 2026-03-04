import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/data/repositories/variant_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/variant/variant_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class VariantFormSheet extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  final int productId;
  final VariantEntity? variant;
  const VariantFormSheet({
    super.key, 
    required this.categoriesBloc, 
    required this.productId, 
    this.variant});

  @override
  State<VariantFormSheet> createState() => _VariantFormSheetState();
}

class _VariantFormSheetState extends State<VariantFormSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => VariantBloc(
          repository: VariantEditRepositoryImpl(),
          variantEntity: widget.variant,
          productId: widget.productId
        ),
        child: BlocListener<VariantBloc, VariantInitial>(
          listenWhen: (p, c) => c.status == VariantStatus.success,
          listener: (context, state) {
            Navigator.pop(context);
            widget.categoriesBloc.add(LoadCategories());
          },
          child: _VariantFormBody(),
        ),
      ),
    );
  }
}

class _VariantFormBody extends StatefulWidget {
  const _VariantFormBody();

  @override
  State<_VariantFormBody> createState() => __VariantFormBodyState();
}

class __VariantFormBodyState extends State<_VariantFormBody> {
  late TextEditingController _nameController;
  late TextEditingController _partsController;

  @override
  void initState() {
    super.initState();
    final name = context.read<VariantBloc>().state.name;
    final parts = context.read<VariantBloc>().state.partsConsumed;
    _nameController = TextEditingController(text: name);
    _partsController = TextEditingController(text: parts.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _partsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VariantBloc, VariantInitial>(
      builder: (context, state) {
        return BaseFormSheet(
          title: state.isEditing ? 'Редактирование' : 'Добавление', 
          isLoading: state.status == VariantStatus.loading,
          canSubmit: state.canSubmit,
          onSave: () => context.read<VariantBloc>().add(VariantSubmitted()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  onChanged: (v) => context.read<VariantBloc>().add(NameChanged(name: v)),
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Краткое название'),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 70,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _partsController,
                  onChanged: (v) => context.read<VariantBloc>().add(PartsConsumedChanged(partsConsumed: int.tryParse(v) ?? -1)),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: ''
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}