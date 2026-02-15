import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/data/models/semi_stock_item.dart';
import 'package:grv/features/product/widgets/semi_stock_form_sheet.dart';

class SemiStockTile extends StatelessWidget {
  final SemiStockItemUi semiStock;
  final int productId;
  final List<int> colorIds;
  const SemiStockTile({
    super.key, 
    required this.semiStock, 
    required this.productId,
    required this.colorIds,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(semiStock.color.name),
      trailing: Text(semiStock.quantity.toString()),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => SemiStockFormSheet(
            nomenclatureBloc: context.read<NomenclatureBloc>(),
            productId: productId,
            usedColorIds: colorIds,
            semiStock: semiStock,
          ),
        );
      },
    );
  }
}