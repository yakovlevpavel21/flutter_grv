import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/stock_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/stock_form_sheet.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class StockRow {
  final ColorEntity color;
  int? rawCount;
  int? builtCount;
  int? builtStockId;
  int? packedCount;
  int? packedStockId;

  StockRow({
    required this.color,
    this.rawCount,
    this.builtCount,
    this.builtStockId,
    this.packedCount,
    this.packedStockId,
  });

  void setRaw(int raw) => rawCount = raw;
  void setBuilt(int built, int id) { builtCount = built; builtStockId = id; }
  void setPacked(int packed, int id) { packedCount = packed; packedStockId = id; }
}


class StocksList extends StatelessWidget {
  final int categoryId;
  final int productId;
  final List<StockEntity> stocks;
  const StocksList({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.stocks
  });

  void _showStockFormSheet(BuildContext context, StockEntity stock) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return StockFormSheet(
          categoriesBloc: context.read<CategoriesBloc>(), 
          stock: stock,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) return const Center(child: Text('Нет продуктов'));

    final groupedStocks = <int, StockRow>{};

    for (final s in stocks) {
      final colorId = s.color.id;
      groupedStocks.putIfAbsent(colorId, () => StockRow(color: s.color));
      
      if (s.state == StockState.built) {
        groupedStocks[colorId]!.setBuilt(s.quantity, s.id);
      } else if (s.state == StockState.packed) {
        groupedStocks[colorId]!.setPacked(s.quantity, s.id);
      }
    }
    
    return ListView(
      children: [
        ...groupedStocks.values.map((v) => ListTile(
          title: Text(v.color.name),
          subtitle: Text('Собрано: ${v.builtCount}\nУпаковано: ${v.packedCount}'),
          leading: SizedBox(
            width: 20,
            height: 20,
            child: ColoredBox(color: v.color.color)
          ),
          trailing: PopupMenuButton<String>(
            itemBuilder: (_) => [
              PopupMenuItem(value: 'edit_built', child: Text('Изменить собранные'),),
              PopupMenuItem(value: 'edit_packed', child: Text('Изменить упакованные'),),
            ],
            onSelected: (value) {
              if (value == 'edit_built') {
                _showStockFormSheet(context, stocks.firstWhere((s) => s.id == v.builtStockId));
              } else if (value == 'edit_packed') {
                _showStockFormSheet(context, stocks.firstWhere((s) => s.id == v.packedStockId));
              }
            },
          )
        )),
      ],
    );
  }
}