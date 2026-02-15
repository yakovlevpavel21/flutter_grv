import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/data/models/variant_item.dart';
import 'package:grv/features/product/data/repos/variant_repo.dart';
import 'package:grv/features/product/logic/variant_bloc.dart';

class VariantFormSheet extends StatefulWidget {
  final NomenclatureBloc nomenclatureBloc;
  final int productId;
  final VariantItemUi? variant;
  const VariantFormSheet({
    super.key, 
    required this.nomenclatureBloc, 
    required this.productId, 
    this.variant});

  @override
  State<VariantFormSheet> createState() => _VariantFormSheetState();
}

class _VariantFormSheetState extends State<VariantFormSheet> {
  late final TextEditingController variantController;
  late final TextEditingController ratioController;

  @override
  void initState() {
    super.initState();
    variantController = TextEditingController(text: widget.variant?.name);
    ratioController = TextEditingController(text: widget.variant?.ratio.toString());
  }

  @override
  void dispose() {
    variantController.dispose();
    ratioController.dispose();
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
        create: (_) => VariantBloc(VariantRepository()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.variant != null ? 'Редактирование' : 'Новый вариант'),
            const SizedBox(height: 16),
            TextField(
              controller: variantController,
              autofocus: true,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Краткое название'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ratioController,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(), 
                labelText: 'Количество полуфабрикатов для изготовления одной единицы этого варианта'
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<VariantBloc, VariantState>(
              listener: (context, state) {
                if (state is VariantSuccess) {
                  Navigator.pop(context);
                  widget.nomenclatureBloc.add(LoadNomenclature());
                }
                if (state is VariantError) {
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
                    onPressed: state is VariantLoading 
                      ? null 
                      : () {
                          final event = widget.variant == null
                            ? CreateVariant(
                                productId: widget.productId,
                                variant: variantController.text, 
                                ratio: int.parse(ratioController.text)
                              )
                            : UpdateVariant(
                                id: widget.variant!.id, 
                                variant: variantController.text, 
                                ratio: int.parse(ratioController.text)
                              );
                              
                          context.read<VariantBloc>().add(event);
                        },
                    child: state is VariantLoading 
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