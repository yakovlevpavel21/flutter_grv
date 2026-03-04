import 'package:flutter/material.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';
import 'package:grv/features/categories/presentation/widgets/variant_card.dart';

class VariantsGrid extends StatelessWidget {
  final int categoryId;
  final int productId;
  final List<VariantEntity> variants;
  const VariantsGrid({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.variants
  });

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) return const Text('Для этого товара вариации отсутствуют.');

    return SizedBox(
      height: 100,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 6,
          childAspectRatio: 0.8
        ), 
        itemCount: variants.length,
        itemBuilder: (_, i) => VariantCard(
          categoryId: categoryId,
          productId: productId,
          variant: variants[i],
        ),
      ),
    );
  }
}
