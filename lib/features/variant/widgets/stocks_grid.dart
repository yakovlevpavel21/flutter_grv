import 'package:flutter/material.dart';
import 'package:grv/features/variant/widgets/stock_card.dart';
import 'package:grv/features/variant/data/models/stock_item.dart';

class StocksGrid extends StatelessWidget {
  final int categoryId;
  final int productId;
  final List<StockItemUi> stocks;
  const StocksGrid({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.stocks
  });

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) return const Center(child: Text('Нет продуктов'));
    
    return ListView(
      children: [
        ...stocks.map((v) => ListTile(
          title: Text(v.color.name),
          trailing: Text('${v.packed} (${v.built})'),
        ))
      ],
    );
    //return GridView.builder(
    //  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //    maxCrossAxisExtent: 200,
    //    mainAxisSpacing: 6,
    //    crossAxisSpacing: 6,
    //    childAspectRatio: 1
    //  ), 
    //  itemCount: stocks.length,
    //  itemBuilder: (_, i) => StockCard(
    //    categoryId: categoryId,
    //    productId: productId,
    //    variant: stocks[i],
    //  ),
    //);
  }
}