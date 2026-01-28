import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/products/data/models/product.dart';
import 'package:grv/features/products/logic/product_bloc.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductModel? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final nameCtrl = TextEditingController();
  final skuCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      skuCtrl.text = widget.product!.sku;
      categoryCtrl.text = widget.product!.category ?? '';
      descCtrl.text = widget.product!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Редактировать товар" : "Добавить товар"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Название")),
            TextField(controller: skuCtrl, decoration: const InputDecoration(labelText: "Артикул")),
            TextField(controller: categoryCtrl, decoration: const InputDecoration(labelText: "Категория")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Описание")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isEdit) {
                  context.read<ProductBloc>().add(
                        UpdateProduct(
                          id: widget.product!.id,
                          name: nameCtrl.text,
                          sku: skuCtrl.text,
                          category: categoryCtrl.text,
                          description: descCtrl.text,
                        ),
                      );
                } else {
                  context.read<ProductBloc>().add(
                        CreateProduct(
                          name: nameCtrl.text,
                          sku: skuCtrl.text,
                          category: categoryCtrl.text,
                          description: descCtrl.text,
                        ),
                      );
                }
                Navigator.pop(context);
              },
              child: const Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }
}
