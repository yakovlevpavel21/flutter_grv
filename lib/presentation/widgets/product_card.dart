import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:grv/data/models/models.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // 📷 Фото (главное — растягивается)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: product.imageUrl != null
                      ? Image.network(
                          product.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.chair, size: 60),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 8),

              // 📝 Название (уменьшается по размеру)
              Text(
                product.name,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              // 📦 Остаток (ВСЕГДА ВИДЕН)
              Text(
                '${product.quantity}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: product.quantity == 0
                      ? Colors.red
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
