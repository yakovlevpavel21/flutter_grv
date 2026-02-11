import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/home/logic/home_bloc.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/mappers/categories_to_stocks_mapper.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/logic/shipments_bloc.dart';
import 'package:grv/features/shipments/widgets/product_tile.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';
import 'package:grv/widgets/empty_state.dart';

class ProductsSheet extends StatelessWidget {
  final BuildContext context;
  final ShipmentType type;
  final String shopName;
  final List<ShipmentProductUi> items;

  const ProductsSheet({
    super.key,
    required this.context,
    required this.type,
    required this.shopName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: type == ShipmentType.shipment
        ? BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                final stocks = state.categories
                        .toProductsUi()
                        .where((p) => p.quantity > 0)
                        .toList();
                        
                return _ListProducts(
                  context: this.context, 
                  type: type,
                  stocks: stocks, 
                  items: items,
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
                  items: items,
                );
              }
              return const SizedBox();
            },
          ),
    );
  }
}

List<ShipmentProductUi> expandProducts(List<ShipmentItemUi> items, String shopName) {
  final Map<int, ShipmentProductUi> map = {};

  for (final sh in items) {
    if (sh.shopName == shopName) {
      for (final pr in sh.products) {
        if (map.containsKey(pr.id)) {
          final existing = map[pr.id]!;

          map[pr.id] = existing.copyWith(
            quantity: existing.quantity + pr.quantity,
          );
        } else {
          map[pr.id] = pr;
        }
      }
    }
  }
  return map.values.toList();
}

class _ListProducts extends StatelessWidget {
  final BuildContext context;
  final ShipmentType type;
  final List<ShipmentProductUi> stocks;
  final List<ShipmentProductUi> items;

  const _ListProducts({
    required this.context,
    required this.type,
    required this.stocks,
    required this.items,
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
                product: p,
                selected: items.any((i) => i.id == p.id),
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
