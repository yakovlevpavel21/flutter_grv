import 'package:flutter/material.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/presentation/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final int categoryId;
  final List<ProductEntity> products;
  const ProductsGrid({super.key, required this.categoryId, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const Center(child: Text('Нет продуктов'));

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: 1
      ), 
      itemCount: products.length,
      itemBuilder: (_, i) => ProductCard(
        categoryId: categoryId,
        product: products[i],
      ),
    );
  }
}