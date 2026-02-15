import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/category/data/models/product_item.dart';
import 'package:grv/features/category/data/repos/products_repo.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/category/logic/product_bloc.dart';

class ProductFormSheet extends StatefulWidget {
  final NomenclatureBloc nomenclatureBloc;
  final int categoryId;
  final ProductItemUi? product;
  const ProductFormSheet({
    super.key, 
    required this.nomenclatureBloc, 
    required this.categoryId, 
    this.product});

  @override
  State<ProductFormSheet> createState() => _ProductFormSheetState();
}

class _ProductFormSheetState extends State<ProductFormSheet> {
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name);
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
        create: (_) => ProductBloc(ProductRepository()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.product != null ? 'Редактирование' : 'Новый товар'),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Название'),
            ),
            const SizedBox(height: 16),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductSuccess) {
                  Navigator.pop(context);
                  widget.nomenclatureBloc.add(LoadNomenclature());
                }
                if (state is ProductError) {
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
                    onPressed: state is ProductLoading 
                      ? null
                      : () {
                          final event = widget.product == null
                            ? CreateProduct(
                                name: nameController.text, 
                                categoryId: widget.categoryId
                              )
                            : UpdateProduct(
                                id: widget.product!.id, 
                                name: nameController.text, 
                                categoryId: widget.categoryId
                              );
                              
                          context.read<ProductBloc>().add(event);
                        },
                    child: state is ProductLoading 
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