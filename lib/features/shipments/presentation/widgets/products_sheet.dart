import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/mappers/categories_to_stocks_mapper.dart';
import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';
import 'package:grv/features/shipments/domain/entities/stock_details_entity.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';
import 'package:grv/features/shipments/presentation/blocs/shipments/shipments_bloc.dart';
import 'package:grv/features/shipments/presentation/widgets/product_tile.dart';

class ProductsSheet extends StatelessWidget {
  final BuildContext context;
  final ShipmentType type;
  final String shopName;
  final List<StockShipmentEntity> selectedStocks;

  const ProductsSheet({
    super.key,
    required this.context,
    required this.type,
    required this.shopName,
    required this.selectedStocks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: type == ShipmentType.shipment
        ? BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                final stocks = state.categories.values.toList()
                        .toStocksUi()
                        .where((s) => s.quantity > 0)
                        .toList();
                        
                return _ListProducts(
                  context: this.context, 
                  type: type,
                  stocks: stocks, 
                  selectedStocks: selectedStocks,
                );
              }
              return const SizedBox();
            },
          )
        : BlocBuilder<ShipmentsBloc, ShipmentsState>(
            builder: (context, state) {
              if (state is ShipmentsLoaded) {
                final stocks = expandProducts(state.items, shopName);
                
                return _ListProducts(
                  context: this.context, 
                  type: type,
                  stocks: stocks, 
                  selectedStocks: selectedStocks,
                );
              }
              return const SizedBox();
            },
          ),
    );
  }
}

List<StockDetailsEntity> expandProducts(List<ShipmentEntity> items, String shopName) {
  final Map<int, StockDetailsEntity> map = {};

  for (final sh in items) {
    if (sh.shop == shopName && sh.type == ShipmentType.shipment) {
      for (final pr in sh.stocks) {
        if (map.containsKey(pr.id)) {
          final existing = map[pr.id]!;

          //map[pr.id] = existing.copyWith(
          //  quantity: existing.quantity + pr.quantity,
          //);
        } else {
          //map[pr.id] = pr;
        }
      }
    }
  }
  return map.values.toList();
}

class _ListProducts extends StatelessWidget {
  final BuildContext context;
  final ShipmentType type;
  final List<StockDetailsEntity> stocks;
  final List<StockShipmentEntity> selectedStocks;

  const _ListProducts({
    required this.context,
    required this.type,
    required this.stocks,
    required this.selectedStocks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (stocks.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Выберите товары',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ] else ...[
          Align(
            alignment: AlignmentGeometry.center,
            child: type == ShipmentType.shipment 
              ? Text('Товаров нет в наличии')
              : Text('В выбранный магазин не поступало товаров. Попробуйте выбрать другой.'),
          )
        ],
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: stocks.map(
              (p) => ProductTile(
                context: this.context,
                stockDetails: p,
                selected: selectedStocks.any((i) => i.id == p.id),
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
