import 'package:flutter/material.dart';
import 'package:grv/features/product/data/models/semi_stock_item.dart';
import 'package:grv/features/product/widgets/semi_stock_tile.dart';
import 'package:grv/features/variant/data/models/stock_item.dart';
import 'package:grv/features/product/data/models/variant_item.dart';
import 'package:grv/features/product/widgets/variant_card.dart';

class SemiStocksList extends StatelessWidget {
  final int categoryId;
  final int productId;
  final List<SemiStockItemUi> semiStocks;
  const SemiStocksList({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.semiStocks
  });

  @override
  Widget build(BuildContext context) {
    if (semiStocks.isEmpty) return const Center(child: Text('Нет продуктов'));

    return ListView.builder(
      itemCount: semiStocks.length,
      itemBuilder: (context, index) {
        return SemiStockTile(
          semiStock: semiStocks[index], 
          productId: productId, 
          colorIds: semiStocks.map((i) => i.color.id).toList()
        );
      },
    );
  }
}