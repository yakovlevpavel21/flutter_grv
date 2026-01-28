import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/products/data/models/product.dart';
import 'package:grv/features/products/logic/product_bloc.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductFormScreen(product: product),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProduct(product.id));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl != null)
              Image.network(product.imageUrl!, height: 200),
            const SizedBox(height: 20),
            Text("Артикул: ${product.sku}"),
            Text("Категория: ${product.category ?? '-'}"),
            Text("Количество: ${product.quantity}"),
            if (product.description != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(product.description!),
              ),
          ],
        ),
      ),
    );
  }
}
