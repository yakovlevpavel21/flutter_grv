import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/nomenclature/data/models/category_item.dart';
import 'package:grv/features/nomenclature/data/repos/category_repo.dart';
import 'package:grv/features/nomenclature/logic/category_bloc.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';

class CategoryFormSheet extends StatefulWidget {
  final NomenclatureBloc nomenclatureBloc;
  final CategoryItemUi? category;
  const CategoryFormSheet({super.key, required this.nomenclatureBloc, this.category});

  @override
  State<CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends State<CategoryFormSheet> {
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.category?.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16, right: 16, top: 16,
      ),
      child: BlocProvider(
        create: (_) => CategoryBloc(CategoryRepository()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.category != null ? 'Редактирование' : 'Новая категория'),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Название'),
            ),
            const SizedBox(height: 16),
            BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategorySuccess) {
                  Navigator.pop(context);
                  widget.nomenclatureBloc.add(LoadNomenclature());
                }
                if (state is CategoryError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message))
                  );
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is CategoryLoading 
                      ? null 
                      : () {
                          final event = widget.category == null
                            ? CreateCategory(name: nameController.text)
                            : UpdateCategory(id: widget.category!.id, name: nameController.text);
                          context.read<CategoryBloc>().add(event);
                        },
                    child: state is CategoryLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Сохранить'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}