import 'package:flutter/material.dart';
import 'package:grv/features/home/data/models/home_category.dart';
import 'package:grv/features/home/presentation/widgets/product_section.dart';

class CategorySection extends StatelessWidget {
  final HomeCategoryUi ui;

  const CategorySection({super.key, required this.ui});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ui.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        ...ui.products.map(
          (p) => ProductSection(ui: p),
        ),
      ],
    );
  }
}